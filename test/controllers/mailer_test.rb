require 'test_helper'

class MailerTest < ActionMailer::TestCase
  setup { ActionMailer::Base.deliveries.clear }

  context "upon trigger of a bulk message" do
    setup do
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      @user = create(:user, email: "test@example.com")
    end

    should "deliver bulk messages" do
      email = Mailer.bulk_message_email(@message.id, @user.id).deliver_now

      assert_equal ["test@example.com"], email.to
      assert_equal "Example Subject",    email.subject
      assert_match /Hello World/,        email.encoded
    end
  end

  context "upon scheduled incomplete reminder email" do
    setup do
      @user = create(:user, email: "test@example.com")
      @message = create(:message, subject: "Incomplete Application", type: 'automated', trigger: 'user.24hr_incomplete_application')
    end

    should "queue reminder bulk message" do
      assert_difference 'Sidekiq::Extensions::DelayedMailer.jobs.size', 1 do
        Mailer.incomplete_reminder_email(@user.id).deliver_now
      end
    end
  end

  context "with customized HackathonConfig" do
    setup do
      @user = create(:user, email: "test@example.com")
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      HackathonConfig['email_from'] = 'This is a test <test@custom.example.com>'
    end

    should "use customized email_from" do
      email = Mailer.bulk_message_email(@message.id, @user.id).deliver_now

      assert_equal ["test@custom.example.com"], email.from
    end
  end
end
