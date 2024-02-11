require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  context "upon trigger of a bulk message" do
    setup do
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      @user = create(:user, email: "test@example.com")
    end

    should "deliver bulk messages" do
      email = UserMailer.bulk_message_email(@message.id, @user.id).deliver_now

      assert_equal ["test@example.com"], email.to
      assert_equal "Example Subject", email.subject
      assert_match /Hello World/, email.encoded
    end
  end

  context "upon scheduled incomplete reminder email" do
    setup do
      @user = create(:user, email: "test@example.com")
      @message = create(:message, subject: "Incomplete Application", type: "automated", trigger: "user.24hr_incomplete_application")
    end

    should "queue reminder bulk message" do
      assert_difference "enqueued_jobs.size", 1 do
        UserMailer.incomplete_reminder_email(@user.id).deliver_later
      end
    end
  end

  context "upon scheduled rsvp reminder email" do
    setup do
      @user = create(:user, email: "test@example.com")
      @message = create(:message, subject: "Are you coming to HackFoo?", type: "automated", trigger: "questionnaire.rsvp_reminder_email")

      should "queue reminder bulk message" do
        assert_difference "enqueued_jobs.size", 1 do
          UserMailer.rsvp_reminder_email(@user.id).deliver_later
        end
      end
    end
  end

  context "with customized HackathonConfig" do
    setup do
      @user = create(:user, email: "test@example.com")
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      HackathonConfig.email_from = "This is a test <test@custom.example.com>"
    end

    should "use customized email_from" do
      email = UserMailer.bulk_message_email(@message.id, @user.id).deliver_now

      assert_equal ["test@custom.example.com"], email.from
    end
  end
end
