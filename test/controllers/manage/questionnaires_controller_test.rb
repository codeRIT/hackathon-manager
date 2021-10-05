require "test_helper"

class Manage::QuestionnairesControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @questionnaire = create(:questionnaire)
    stub_request(:get, /api.sendgrid.com.*/).to_return(status: 200, body: "", headers: {})
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_questionnaires#index" do
      get :index
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Human Centered Computing" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { id: @questionnaire }
      assert_response :unauthorized
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @questionnaire.user
      @request.headers["Authorization"] = "Bearer " + @questionnaire.user.generate_jwt
    end

    should "not allow access to manage_questionnaires#index" do
      get :index
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { id: @questionnaire }
      assert_response :unauthorized
    end
  end

  context "while authenticated as a volunteer" do
    setup do
      @user = create(:volunteer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = "Bearer " + @user.generate_jwt
    end

    should "allow access to manage_questionnaires#index" do
      get :index, format: :json
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }, format: :json
      assert_response :success
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_response :unauthorized
    end

    should "allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { bulk_action: "waitlist", bulk_ids: [@questionnaire.id] }
      assert_response :success
    end
  end

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = "Bearer " + @user.generate_jwt
    end

    should "allow access to manage_questionnaires#index" do
      get :index, format: :json
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }, format: :json
      assert_response :success
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :unauthorized
    end

    should "not access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_response :unauthorized
    end

    should "allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { bulk_action: "waitlist", bulk_ids: [@questionnaire.id] }
      assert_response :success
    end
  end

  context "while authenticated as a director" do
    setup do
      @user = create(:director)
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @user
      @request.headers["Authorization"] = "Bearer " + @user.generate_jwt
    end

    should "allow access to manage_questionnaires#index" do
      get :index, format: :json
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }, format: :json
      assert_response :success
    end

    context "destroy questionnaire" do
      should "if bus captain, notify directors that bus captain has been removed" do
        @user = create(:director)
        @questionnaire.update_attribute(:is_bus_captain, true)
        assert_difference('enqueued_jobs.size', User.where(role: :director).size) do
          delete :destroy, params: { id: @questionnaire }
        end
      end

      should "user destroy questionnaire" do
        assert_difference('Questionnaire.count', -1) do
          delete :destroy, params: { id: @questionnaire }
        end
        assert_response :success
      end
    end

    should "check in the questionnaire through api" do
      patch :check_in, params: { id: @questionnaire, check_in: "true" }
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :success
    end

    should "check out the questionnaire through api" do
      patch :check_in, params: { id: @questionnaire, check_in: "false" }
      assert_nil @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :success
    end

    should "require all agreements to be accepted to check in" do
      @questionnaire.update_attribute(:agreements, [])
      patch :check_in, params: { id: @questionnaire, check_in: "true" }
      assert_nil @questionnaire.reload.checked_in_at
      assert_nil @questionnaire.reload.checked_in_by_id
      assert_response :unprocessable_entity
    end

    should "accept all agreements and check in" do
      @questionnaire.update_attribute(:agreements, Agreement.all)
      patch :check_in, params: { id: @questionnaire, check_in: "true", questionnaire: { agreement_accepted: 1 } }
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :ok
    end

    should "allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_equal @user.id, @questionnaire.reload.acc_status_author_id
      assert_not_equal nil, @questionnaire.reload.acc_status_date
      assert_response :success
    end

    should "allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { bulk_action: "accepted", bulk_ids: [@questionnaire.id] }
      assert_response :success
      assert_equal "accepted", @questionnaire.reload.acc_status
    end

    should "fail manage_questionnaires#bulk_apply when missing action" do
      assert_difference "enqueued_jobs.size", 0 do
        patch :bulk_apply, params: { bulk_ids: [@questionnaire.id] }
      end
      assert_response :bad_request
    end

    should "fail manage_questionnaires#bulk_apply when missing ids" do
      assert_difference "enqueued_jobs.size", 0 do
        patch :bulk_apply, params: { id: @questionnaire }
      end
      assert_response :bad_request
    end

    ["accepted", "denied", "rsvp_confirmed"].each do |status|
      should "send notification emails appropriately for #{status} bulk_apply" do
        create(:message, type: "automated", trigger: "questionnaire.#{status}")
        assert_difference "enqueued_jobs.size", 1 do
          patch :bulk_apply, params: { bulk_action: status, bulk_ids: [@questionnaire.id] }
        end
      end
    end

    should "fail manage_questionnaires#update_acc_status when missing status" do
      assert_difference "enqueued_jobs.size", 0 do
        patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "" } }
      end
      assert_response :unprocessable_entity
    end

    ["accepted", "denied", "rsvp_confirmed"].each do |status|
      should "send notification emails appropriately for #{status} update_acc_status" do
        create(:message, type: "automated", trigger: "questionnaire.#{status}")
        assert_difference "enqueued_jobs.size", 1 do
          patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: status } }
        end
      end
    end
  end
end
