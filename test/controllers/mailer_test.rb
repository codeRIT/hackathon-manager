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
    end

    should "deliver reminder email" do
      email = Mailer.incomplete_reminder_email(@user.id).deliver_now

      assert_equal ["test@example.com"],     email.to
      assert_equal "Incomplete Application", email.subject
      assert_match %r{hackathon_manager.example.com\/apply}, email.encoded
    end
  end

  context "upon slack invite email" do
    setup do
      @questionnaire = create(:questionnaire)
      @questionnaire.user.update_attribute(:email, "test@example.com")
    end

    should "deliver invite email" do
      email = Mailer.slack_invite_email(@questionnaire.id).deliver_now

      assert_equal ["test@example.com"], email.to
      assert_equal "Slack Invite!", email.subject
      assert_match %r{slack.com\/shared_invite}, email.encoded
    end
  end

  context "upon scheduled bus update email" do
    setup do
      @bus_list = create(:bus_list)
      @questionnaire = create(:questionnaire, acc_status: 'rsvp_confirmed', riding_bus: true)
      @questionnaire.school.update_attribute(:bus_list_id, @bus_list.id)
      @questionnaire.user.update_attribute(:email, "test@example.com")
    end

    should "deliver update email" do
      email = Mailer.bus_list_update_email(@questionnaire.id).deliver_now

      assert_equal ["test@example.com"], email.to
      assert_equal "Bus Update", email.subject
      assert_match %r{brickhack.io\/rsvp}, email.encoded
    end
  end
end
