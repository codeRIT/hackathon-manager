require "test_helper"

class StaffMailerTest < ActionMailer::TestCase
  context "weekly_report" do
    setup do
      @user = create(:user, email: "test@example.com", receive_weekly_report: true)
      # Setup initial data to trigger regular report
      HackathonConfig["event_start_date"] = Date.today.to_s
      @questionnaire = create(:questionnaire, created_at: 5.days.ago)
    end

    should "deliver weekly email report" do
      email = StaffMailer.weekly_report(@user.id).deliver_now

      assert_equal ["test@example.com"], email.to
      assert_equal "Your Weekly Report", email.subject
      assert_match /new application/, email.encoded
    end

    should "not send when more than 7 days after event started" do
      HackathonConfig["event_start_date"] = 10.days.ago.to_s
      email = StaffMailer.weekly_report(@user.id).deliver_now
      assert_nil email
    end

    should "not send if staff member is inactive" do
      @user.update_attribute(:is_active, false)
      email = StaffMailer.weekly_report(@user.id).deliver_now
      assert_nil email
    end

    should "not send if staff member isn't receiving weekly reports" do
      @user.update_attribute(:receive_weekly_report, false)
      email = StaffMailer.weekly_report(@user.id).deliver_now
      assert_nil email
    end

    should "not send if there hasn't been new activity" do
      @questionnaire.update_attribute(:created_at, Date.today)
      email = StaffMailer.weekly_report(@user.id).deliver_now
      assert_nil email
    end
  end
end
