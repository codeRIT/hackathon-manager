class DataExport < ApplicationRecord

  # A DataExport is a generated .zip of data from HackathonManager, such as a .zip of
  # resumes & attendee data, or a .zip of the entire database is the form of multiple
  # CSVs.
  #
  # These should be generated asynchronously with a background job, and then stored as an
  # active storage attachment.

  POSSIBLE_TYPES = [
    "sponsor_dump_rsvp_confirmed",
    "sponsor_dump_checked_in",
  ].freeze

  validates_presence_of :export_type
  validates_inclusion_of :export_type, in: POSSIBLE_TYPES

  has_one_attached :file

  strip_attributes

  def file_basename
    time = created_at.strftime("%r").gsub(":", "-")
    date = created_at.strftime("%F")
    "#{export_type} #{date} #{time}"
  end

  def finished?
    finished_at.present?
  end

  def started?
    started_at.present?
  end

  def queued?
    queued_at.present?
  end

  def enqueue!
    raise "Data export has already been queued" unless status == "created_not_queued"

    update_attribute(:queued_at, Time.now)
    GenerateDataExportJob.perform_later(self)
  end

  def status
    return "finished" if finished?
    return "started" if started?
    return "queued" if queued?

    "created_not_queued"
  end
end
