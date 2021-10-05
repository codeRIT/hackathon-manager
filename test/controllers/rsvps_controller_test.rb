require "test_helper"

class RsvpsControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = build(:questionnaire, school_id: @school.id)
    @agreement = create(:agreement)
    @questionnaire.agreements << @agreement
    @questionnaire.save
  end

  context "while not authenticated" do
    should "redirect to sign in page on rsvp#accept" do
      patch :accept
      assert_response :unauthorized
    end

    should "redirect to sign in page on rsvp#deny" do
      patch :deny
      assert_response :unauthorized
    end
  end

  context "while authenticated without a questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      @user = create(:user, email: "newabc@example.com")
      @request.headers["Authorization"] = "Bearer " + @user.generate_jwt
      sign_in @user
    end

    should "return forbidden on rsvp#accept" do
      patch :accept
      assert_response :forbidden
    end

    should "return forbidden on rsvp#deny" do
      patch :deny
      assert_response :forbidden
    end
  end

  context "while authenticated with a non-accepted questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      @request.headers["Authorization"] = "Bearer " + @questionnaire.user.generate_jwt
      sign_in @questionnaire.user
      @questionnaire.acc_status = "denied"
    end

    should "return forbidden on rsvp#accept" do
      patch :accept
      assert_response :forbidden
    end

    should "return forbidden on rsvp#deny" do
      patch :deny
      assert_response :forbidden
    end
  end

  context "while authenticated with an accepted questionnaire" do
    setup do
      clear_enqueued_jobs
      @request.env["devise.mapping"] = Devise.mappings[:director]
      @request.headers["Authorization"] = "Bearer " + @questionnaire.user.generate_jwt
      sign_in @questionnaire.user
      @questionnaire.update_attribute(:acc_status, "accepted")
    end

    context "not update status for invalid questionnaire" do
      setup do
        @questionnaire.update_attribute(:acc_status, "accepted")
        @questionnaire.update_attribute(:agreements, [])
      end

      [:accept, :deny].each do |status|
        context "attempting #{status}" do
          should "not change acceptance status" do
            patch status
            assert_equal "accepted", @questionnaire.reload.acc_status
          end
        end
      end
    end

    should "update the questionnaire status to accepted" do
      create(:message, type: "automated", trigger: "questionnaire.rsvp_confirmed")
      patch :accept
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal 1, enqueued_jobs.size, "should email confirmation to questionnaire"
      assert_response :ok
    end

    should "update the questionnaire status to denied" do
      patch :deny
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_equal 0, enqueued_jobs.size, "no emails should be sent"
      assert_response :ok
    end
  end
end
