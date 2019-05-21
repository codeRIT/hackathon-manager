require "test_helper"

class UserTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  should strip_attribute :email

  should validate_uniqueness_of :email

  should validate_presence_of :email
  should validate_presence_of :password

  should "downcase emails" do
    s = build(:user, email: "Test@ExAmPlE.cOm")
    assert_equal "test@example.com", s.email
  end

  should allow_value("test@example.com").for(:email)
  should_not allow_value("abcd").for(:email)

  context "first_name" do
    should "return first name when questionnaire exists" do
      questionnaire = create(:questionnaire, first_name: "Alpha")
      assert_equal "Alpha", questionnaire.user.first_name
    end

    should "return blank when no questionnaire exists" do
      user = create(:user)
      assert_equal "", user.first_name
    end
  end

  context "last_name" do
    should "return last name when questionnaire exists" do
      questionnaire = create(:questionnaire, last_name: "Beta")
      assert_equal "Beta", questionnaire.user.last_name
    end

    should "return blank when no questionnaire exists" do
      user = create(:user)
      assert_equal "", user.last_name
    end
  end

  context "full_name" do
    should "return full name when questionnaire exists" do
      questionnaire = create(:questionnaire, first_name: "Alpha", last_name: "Beta")
      assert_equal "Alpha Beta", questionnaire.user.full_name
    end

    should "return blank when no questionnaire exists" do
      user = create(:user)
      assert_equal "", user.full_name
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

    should "not return admins" do
      create(:questionnaire) # user, has questionnaire
      create(:user, role: :event_tracking) # user, does not
      create(:user, role: :admin_limited_access) # admin, does not
      create(:user, role: :admin) # admin, does not
      assert_equal 4, User.count
      assert_equal 1, User.without_questionnaire.count
    end
  end

  should "queue reminder email" do
    assert_difference "enqueued_jobs.size", 1 do
      create(:user)
    end
  end
end
