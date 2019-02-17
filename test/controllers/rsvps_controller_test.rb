require 'test_helper'

class RsvpsControllerTest < ActionController::TestCase
  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = create(:questionnaire, school_id: @school.id)
  end

  context "while not authenticated" do
    should "redirect to sign in page on rsvp#index" do
      get :show
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#accept" do
      get :accept
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#deny" do
      get :deny
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#update" do
      patch :update
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated without a questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = create(:user, email: "newabc@example.com")
      sign_in @user
    end

    should "redirect to root page on rsvp#index" do
      get :show
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update
      assert_redirected_to new_questionnaires_path
    end
  end

  context "while authenticated with a non-accepted questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.acc_status = "denied"
    end

    should "redirect to root page on rsvp#index" do
      get :show
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update
      assert_redirected_to new_questionnaires_path
    end
  end

  context "while authenticated with an accepted questionnaire" do
    setup do
      ActionMailer::Base.deliveries = []
      Sidekiq::Extensions::DelayedMailer.jobs.clear

      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.update_attribute(:acc_status, "accepted")
    end

    should "display rsvp page" do
      get :show
      assert_response :success
    end

    context "not update status for invalid questionnaire" do
      setup do
        @questionnaire.update_attribute(:agreement_accepted, false)
        @questionnaire.update_attribute(:acc_status, "accepted")
      end

      [:accept, :deny].each do |status|
        context "attempting #{status}" do
          should "include error message" do
            get status
            assert_match /was an error/, flash[:notice]
          end

          should "not change acceptance status" do
            get status
            assert_equal "accepted", @questionnaire.reload.acc_status
          end

          should "include hackathon name in notice" do
            HackathonConfig['name'] = 'Foo Bar'
            get status
            assert_match /Foo Bar Agreement/, flash[:notice]
          end
        end
      end
    end

    should "update the questionnaire status to accepted" do
      create(:message, type: 'automated', trigger: 'questionnaire.rsvp_confirmed')
      get :accept
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to questionnaire"
      assert_redirected_to rsvp_path
    end

    should "update the questionnaire status to denied" do
      get :deny
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent"
      assert_redirected_to rsvp_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update, params: { questionnaire: { acc_status: "rsvp_denied" } }
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_redirected_to rsvp_path
    end

    should "not allow riding a bus if bus is full" do
      bus_list = create(:bus_list, capacity: 0)
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal false, @questionnaire.reload.bus_list_id?
      assert_equal 0, bus_list.passengers.count
      assert_match /full/, flash[:notice]
      assert_no_match /still signed up/, flash[:notice]
      assert_redirected_to rsvp_path
    end

    should "allow getting off a full bus" do
      bus_list = create(:bus_list, capacity: 1)
      assert_equal 0, bus_list.passengers.count
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_equal 1, bus_list.passengers.count
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: '' } }
      assert_equal 0, bus_list.passengers.count
    end

    should "not allow switching to a full bus" do
      bus_list1 = create(:bus_list, capacity: 1)
      bus_list2 = create(:bus_list, capacity: 0)
      # Initial sign up
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list1.id } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal 1, bus_list1.passengers.count
      assert_equal 0, bus_list2.passengers.count
      # Try to switch busses
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list2.id } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal 0, bus_list2.passengers.count, 'passenger should not be assigned to bus that is full'
      assert_equal 1, bus_list1.passengers.count, 'passenger should stay on original bus'
      assert_match /full/, flash[:notice]
      assert_match /still signed up/, flash[:notice]
      assert_redirected_to rsvp_path
    end

    should "not error if submitting while already on a full bus" do
      bus_list = create(:bus_list, capacity: 1)
      # Initial sign up
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_no_match /full/, flash[:notice], 'should not complain about bus being full'
      # Submit again
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_no_match /full/, flash[:notice], 'should not complain about bus being full'
    end

    should "not send email if updating info after confirming" do
      @questionnaire.update_attribute(:acc_status, "rsvp_confirmed")
      create(:message, type: 'automated', trigger: 'questionnaire.rsvp_confirmed')
      bus_list = create(:bus_list)
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent"
    end

    should "allow riding a bus list" do
      bus_list = create(:bus_list)
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", bus_list_id: bus_list.id } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal true, @questionnaire.bus_list_id?
      assert_equal 1, bus_list.passengers.count
      assert_redirected_to rsvp_path
    end

    should "allow updates to questionnaire via rsvp page" do
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_equal "1234567890", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow invalid updates to questionnaire via rsvp page" do
      @questionnaire.update_attribute(:phone, "1111111111")
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_not_nil flash[:notice]
      assert_equal "1111111111", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow updates to invalid questionnaire via rsvp page" do
      @questionnaire.update_attribute(:phone, "1111111111")
      @questionnaire.update_attribute(:first_name, "")
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_not_nil flash[:notice]
      assert_equal "1111111111", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow forbidden status update to questionnaire" do
      patch :update, params: { questionnaire: { acc_status: "pending" } }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_match /select a RSVP status/, flash[:notice]
      assert_redirected_to rsvp_path
    end
  end
end
