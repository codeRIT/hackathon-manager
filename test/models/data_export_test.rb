require "test_helper"

class DataExportTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  should strip_attribute :export_type
  should validate_presence_of :export_type
  should_not validate_presence_of :queued_at
  should_not validate_presence_of :started_at
  should_not validate_presence_of :finished_at

  should allow_value("sponsor_dump_rsvp_confirmed").for(:export_type)
  should allow_value("sponsor_dump_checked_in").for(:export_type)
  should_not allow_value("foo").for(:export_type)

  context "#file_basename" do
    should "use mix of type, date, and time" do
      # Set consistent local time
      Timecop.freeze(DateTime.new(2020, 01, 15, 4, 5, 6, 0))
      timezone_offset = DateTime.now.offset
      data_export = build(
        :data_export,
        # 4:05:06 AM on 1/15/2020 in current time zone
        created_at: DateTime.new(2020, 01, 15, 4, 5, 6, timezone_offset),
        export_type: "sponsor_dump_rsvp_confirmed",
      )
      assert_equal "sponsor_dump_rsvp_confirmed 2020-01-15 04-05-06 AM", data_export.file_basename
      # Restore global time
      Timecop.return
    end
  end

  context "#enqueue" do
    should "enqueue active job" do
      assert_difference("enqueued_jobs.size", 1) do
        data_export = create(:data_export, export_type: "sponsor_dump_rsvp_confirmed")
        data_export.enqueue!
      end
    end

    should "not enqueue already queued export" do
      assert_difference("enqueued_jobs.size", 0) do
        assert_raises(Exception) do
          data_export = create(:data_export, export_type: "sponsor_dump_rsvp_confirmed", queued_at: Time.now)
          data_export.enqueue!
        end
      end
    end
  end
end
