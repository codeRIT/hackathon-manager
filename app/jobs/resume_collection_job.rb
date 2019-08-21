class ResumeCollectionJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    AdminMailer.resume_collection(job.arguments.first, ).deliver_now
  end

  def perform(user_id, message)
    questionnaires = Questionnaire.where("can_share_info = 1 AND (acc_status = 'rsvp_confirmed' OR checked_in_at > 0)")

        Dir.mktmpdir('resume-bundle') do |dir|
        Dir.mkdir(File.join(dir, "resumes"))
        zipfile_name = Date.today.strftime('%Y-%m-%d') + '-resumes.zip'
        zipfile_path = File.join(dir, zipfile_name)
    
        # Download all of the resumes
        resume_paths = []
        questionnaires.each do |q|
            next unless q.can_share_info? && q.resume.exists?
            download = open(q.resume.expiring_url)
            filename = "#{q.id}-#{q.resume.original_filename}"
            path = File.join(dir, "resumes", filename)
            IO.copy_stream(download, path)
            resume_paths << { path: path, filename: filename }
        end
    
        # Zip up all of the files
        Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
            resume_paths.each do |resume|
            path = resume[:path]
            filename = resume[:filename]
            # Two arguments:
            # - The name of the file as it will appear in the archive
            # - The original file, including the path to find it
            zipfile.add(filename, path)
            end
        end

        # Upload the zip to S3
        s3 = Aws::S3::Resource.new
        bucket = ENV['AWS_BUCKET']
        obj = s3.bucket(bucket).object(zipfile_name)
        obj.upload_file(zipfile_path)

        # Generate a temporary link
        signer = Aws::S3::Presigner.new
        message = signer.presigned_url(:get_object, bucket: bucket, key: zipfile_name)
  end
end
