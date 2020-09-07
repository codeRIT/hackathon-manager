require "test_helper"

class UserTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  should strip_attribute :first_name
  should strip_attribute :last_name
  should strip_attribute :email

  should validate_uniqueness_of :email

  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :email
  should validate_presence_of :password

  should "downcase emails" do
    s = build(:user, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  should allow_value("test@example.com").for(:email)
  should_not allow_value("abcd").for(:email)

  context "full_name" do
    should "concatenate first and last name" do
      user = create(:user)
      assert_equal "John Doe", user.full_name
    end
  end

  context "queue_reminder_email" do
    setup do
      clear_enqueued_jobs
    end

    should "queue an email to be sent out" do
      user = create(:user)
      user.queue_reminder_email
      assert_equal 1, enqueued_jobs.size
    end

    should "only queue email once" do
      user = create(:user)
      user.queue_reminder_email
      user.queue_reminder_email
      user.queue_reminder_email
      assert_equal 1, enqueued_jobs.size
    end
  end

  context "without_questionnaire" do
    should "not return users with a questionnaire" do
      create_list(:questionnaire, 3)
      assert_equal 3, User.count
      assert_equal 0, User.without_questionnaire.count
    end

    should "return users without questionnaire" do
      create_list(:questionnaire, 1)
      create_list(:user, 2)
      create_list(:questionnaire, 3)
      assert_equal 6, User.count
      assert_equal 2, User.without_questionnaire.count
    end

    should "not return staff" do
      create(:questionnaire) # user, has questionnaire
      create(:user, role: :volunteer) # volunteer, does not
      create(:user, role: :organizer) # organizer, does not
      create(:user, role: :director) # director, does not
      assert_equal 4, User.count
      assert_equal 1, User.without_questionnaire.count
    end
  end

  should "queue reminder email" do
    assert_difference "enqueued_jobs.size", 1 do
      create(:user)
    end
  end

  context "safe_receive_weekly_report" do
    should "return false if user is inactive" do
      user = build(:user, is_active: true, receive_weekly_report: true)
      assert_equal true, user.safe_receive_weekly_report
      user.is_active = false
      assert_equal false, user.safe_receive_weekly_report
    end
  end
end
