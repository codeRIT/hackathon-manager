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
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response 401
    end

    should "not allow access to manage_questionnaires#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, params: { questionnaire: { major: "Computer Science" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Human Centered Computing" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @questionnaire.user
    end

    should "not allow access to manage_questionnaires#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, params: { questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  context "while authenticated as a volunteer" do
    setup do
      @user = create(:volunteer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_questionnaires datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :success
    end

    should "not allow access to manage_questionnaires#new" do
      get :new, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, params: { questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
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
    end

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_questionnaires datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :success
    end

    should "not allow access to manage_questionnaires#new" do
      get :new, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, params: { questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#update" do
      patch :update, params: { id: @questionnaire, questionnaire: { major: "Best Major" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, params: { id: @questionnaire }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
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
    end

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_questionnaires#new" do
      get :new
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, params: { id: @questionnaire }
      assert_response :success
    end

    should "allow access to manage_questionnaires#edit" do
      get :edit, params: { id: @questionnaire }
      assert_response :success
    end

    should "not create a duplicate questionnaire for a user" do
      user = create(:user, email: "existing@example.com")
      create(:questionnaire, user_id: user.id)
      assert_difference("User.count", 0) do
        assert_difference("Questionnaire.count", 0) do
          post :create, params: {
            questionnaire: {
              experience: @questionnaire.experience,
              interest: @questionnaire.interest,
              first_name: @questionnaire.user.first_name,
              last_name: @questionnaire.user.last_name,
              phone: @questionnaire.phone,
              level_of_study: @questionnaire.level_of_study,
              date_of_birth: @questionnaire.date_of_birth,
              shirt_size: @questionnaire.shirt_size,
              school_id: @questionnaire.school_id,
              email: "existing@example.com",
              agreement_accepted: "1",
              code_of_conduct_accepted: "1",
              data_sharing_accepted: "1",
              gender: @questionnaire.gender,
              major: @questionnaire.major,
              why_attend: @questionnaire.why_attend,
              graduation_year: @questionnaire.graduation_year,
              race_ethnicity: @questionnaire.race_ethnicity
            }
          }
        end
      end
      assert_response :success
    end

    # This and email are seaparte as they are still implemented separately.
    should "update questionnaire's user's first and last name" do
      patch :update, params: {
        id: @questionnaire,
        questionnaire: {
          user: {
            "first_name": "firstnametest",
            "last_name": "lastnametest"
          }
        }
      }
      assert_equal "firstnametest", assigns(:questionnaire).user.first_name
      assert_equal "lastnametest", assigns(:questionnaire).user.last_name
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "update questionnaire's user email" do
      patch :update, params: { id: @questionnaire, questionnaire: { email: "update@example.com" } }
      assert_equal "update@example.com", assigns(:questionnaire).email
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    context "destroy questionnaire" do
      should "if bus captain, notify admins that bus captain has been removed" do
        @user = create(:admin)
        @questionnaire.update_attribute(:is_bus_captain, true)
        assert_difference('enqueued_jobs.size', User.where(role: :admin).size) do
          delete :destroy, params: { id: @questionnaire }
        end
      end

      should "user destroy questionnaire" do
        assert_difference('Questionnaire.count', -1) do
          delete :destroy, params: { id: @questionnaire }
        end
        assert_redirected_to manage_questionnaires_path
      end
    end

    should "check in the questionnaire" do
      patch :check_in, params: { id: @questionnaire, check_in: "true" }
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_match /Checked in/, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "check in the questionnaire and update information" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      @questionnaire.update_attribute(:can_share_info, false)
      @questionnaire.update_attribute(:phone, "")
      patch :check_in, params: {
        id: @questionnaire,
        check_in: "true",
        questionnaire: {
          agreement_accepted: 1,
          can_share_info: 1,
          phone: "(123) 333-3333",
          email: "new_email@example.com"
        }
      }
      @questionnaire.reload
      assert 1.minute.ago < @questionnaire.checked_in_at
      assert_equal @user.id, @questionnaire.checked_in_by_id
      assert_equal true, @questionnaire.agreement_accepted
      assert_equal true, @questionnaire.can_share_info
      assert_equal "(123) 333-3333", @questionnaire.phone
      assert_equal "new_email@example.com", @questionnaire.email
      assert_match /Checked in/, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "require a new action to check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      @questionnaire.update_attribute(:can_share_info, false)
      @questionnaire.update_attribute(:phone, "")
      @questionnaire.user.update_attribute(:email, "old_email@example.com")
      @questionnaire.update_attribute(:checked_in_at, nil)
      @questionnaire.update_attribute(:checked_in_by_id, nil)
      patch :check_in, params: {
        id: @questionnaire,
        check_in: "",
        questionnaire: {
          agreement_accepted: 1,
          can_share_info: 1,
          phone: "(123) 333-3333",
          email: "new_email@example.com"
        }
      }
      @questionnaire.reload
      assert_nil @questionnaire.checked_in_at
      assert_nil @questionnaire.checked_in_by_id
      assert_equal false, @questionnaire.agreement_accepted
      assert_equal false, @questionnaire.can_share_info
      assert_equal "", @questionnaire.phone
      assert_equal "old_email@example.com", @questionnaire.email
      assert_match /No check-in action provided/, flash[:alert]
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path(@questionnaire)
    end

    should "require agreement_accepted to check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :check_in, params: { id: @questionnaire, check_in: "true" }
      assert_nil @questionnaire.reload.checked_in_at
      assert_nil @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path(@questionnaire)
    end

    should "accept agreement and check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :check_in, params: { id: @questionnaire, check_in: "true", questionnaire: { agreement_accepted: 1 } }
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "undo check in of the questionnaire" do
      patch :check_in, params: { id: @questionnaire, check_in: "false" }
      assert_nil @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_match /no longer/, flash[:notice]
      assert_redirected_to manage_questionnaires_path
    end

    should "allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, params: { id: @questionnaire, questionnaire: { acc_status: "accepted" } }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_equal @user.id, @questionnaire.reload.acc_status_author_id
      assert_not_equal nil, @questionnaire.reload.acc_status_date
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path @questionnaire
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
      assert_response 400
    end

    should "fail manage_questionnaires#bulk_apply when missing ids" do
      assert_difference "enqueued_jobs.size", 0 do
        patch :bulk_apply, params: { id: @questionnaire }
      end
      assert_response 400
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
      assert_response :redirect
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
