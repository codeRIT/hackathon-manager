require "test_helper"

class AdminWeeklyReportJobTest < ActiveJob::TestCase
  should "queue a mailer per recipient" do
    create_list(:user, 3, receive_weekly_report: true)
    create_list(:user, 2, receive_weekly_report: false)
    assert_difference "enqueued_jobs.size", 3 do
      worker = AdminWeeklyReportJob.new
      worker.perform
    end
  end
end
