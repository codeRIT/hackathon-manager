require 'test_helper'

class Manage::UsersControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @user = create(:user)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_users#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
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

    should "not allow access to manage_users#index" do
      get :index
      assert_redirected_to manage_root_path
    end

    /
    READ ME! The below test cases might seem confusing. If the organizer shouldn't have permission to users why are they
    beind redirected to index? See application_controller.rb:27. They're redirected to the controller's index and then
    redirected to manage_root_path on attempt.
    /

    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_redirected_to manage_root_path
    end

    should "not allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_redirected_to manage_users_path
    end
  end

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_redirected_to manage_root_path
    end

    /
    READ ME! The below test cases might seem confusing. If the organizer shouldn't have permission to users why are they
    beind redirected to index? See application_controller.rb:27. They're redirected to the controller's index and then
    redirected to manage_root_path on attempt.
    /

    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_redirected_to manage_root_path
    end

    should "not allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_redirected_to manage_users_path
    end
  end

  context "while authenticated as a director" do
    setup do
      @user = create(:director)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_users#index" do
      get :index
      assert_response :success
    end

    should "be able to reset a user's password" do
      assert_difference "enqueued_jobs.size", 1 do
        patch :reset_password, params: { id: @user }
      end
      assert_redirected_to manage_users_path
    end

    should "allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :success
    end

    should "allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_response :success
    end

    should "update user" do
      patch :update, params: { id: @user, user: { email: "test@example.coma" } }
      assert_redirected_to manage_users_path
    end

    should "destroy user" do
      assert_difference('User.count', -1) do
        patch :destroy, params: { id: @user }
      end
      assert_redirected_to manage_users_path
    end

    should "destroy user and user's questionnaire" do
      @questionnaire = create(:questionnaire, user_id: @user.id)
      assert_difference('Questionnaire.count', -1) do
        patch :destroy, params: { id: @user }
      end
      assert_redirected_to manage_users_path
    end
  end
end
