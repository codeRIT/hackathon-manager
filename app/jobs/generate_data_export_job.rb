require "zip"

class GenerateDataExportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    data_export = args[0]
    # Prevent an already-started or already-completed job from running again
    return unless data_export.status == "queued"

    data_export.update_attribute(:started_at, Time.now)

    begin
      case data_export.export_type
      when "sponsor_dump_rsvp_confirmed"
        generate__sponsor_dump(data_export, "rsvp_confirmed")
      when "sponsor_dump_checked_in"
        generate__sponsor_dump(data_export, "checked_in")
      else
        raise "Unknown export type: #{data_export.export_type}"
      end

      data_export.update_attribute(:finished_at, Time.now)
    rescue => ex
      data_export.update_attribute(:started_at, nil)
      data_export.update_attribute(:finished_at, nil)
      # Re-raise the original exception
      raise
    end
  end

  private

  def generate__sponsor_dump(data_export, attendee_type)
    print data_export.file.name

    case attendee_type
    when "rsvp_confirmed"
      questionnaires = Questionnaire.where(acc_status: "rsvp_confirmed", can_share_info: true)
    when "checked_in"
      questionnaires = Questionnaire.where("checked_in_at > 0", can_share_info: true)
    else
      raise "Unknown attendee type: #{attendee_type}"
    end

    Dir.mktmpdir("data-export") do |dir|
      folder_path = File.join(dir, data_export.file_basename)
      Dir.mkdir(folder_path)
      zipfile_name = "#{data_export.file_basename}.zip"
      zipfile_path = File.join(dir, zipfile_name)

      # Download all of the resumes & generate CSV
      csv_data = []
      resume_paths = []
      questionnaires.each do |q|
        csv_row = [
          q.user.first_name,
          q.user.last_name,
          q.user.email,
          q.school_name,
          q.vcs_url,
          q.portfolio_url,
        ]

        if q.resume.attached?
          filename = "#{q.id}-#{q.resume.filename.sanitized}"
          puts "--> Downloading #{q.id} resume, filename '#{filename}'"
          path = File.join(folder_path, filename)
          File.open(path, "wb") do |file|
            file.write(q.resume.download)
          end
          resume_paths << { path: path, filename: filename }
          csv_row << filename
        else
          csv_row << "" # No resume file
        end

        csv_data << csv_row
      end

      csvfile_name = "000-Attendees.csv"
      csvfile_path = File.join(folder_path, csvfile_name)
      CSV.open(csvfile_path, "wb") do |csv|
        csv << ["First name", "Last name", "Email", "School", "VCS URL", "Portfolio URL", "Resume Filename"]
        csv_data.each do |row|
          csv << row
        end
      end

      # Zip up all of the files
      Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
        # Add the CSV
        zipfile.add(csvfile_name, csvfile_path)
        # Add all resume files
        resume_paths.each do |resume|
          path = resume[:path]
          filename = resume[:filename]
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zipfile.add(filename, path)
        end
      end

      # Attach the zip file to the record
      data_export.file.attach(
        io: File.open(zipfile_path),
        filename: zipfile_name,
        content_type: "application/zip",
      )
    end
  end
end
