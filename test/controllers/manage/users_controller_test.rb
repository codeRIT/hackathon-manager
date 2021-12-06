require 'test_helper'

class Manage::UsersControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @user = create(:user)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_users#index" do
      get :index
      assert_response :unauthorized
    end


    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :unauthorized
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = Devise::JWT::TestHelpers.auth_headers(@request.headers, @user)["Authorization"]
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_response :unauthorized
    end

    should "not allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :unauthorized
    end
  end

  context "while authenticated as a volunteer" do
    setup do
      @user = create(:volunteer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = Devise::JWT::TestHelpers.auth_headers(@request.headers, @user)["Authorization"]
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_response :unauthorized
    end

    should "allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :unauthorized
    end
  end

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = Devise::JWT::TestHelpers.auth_headers(@request.headers, @user)["Authorization"]
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_response :unauthorized
    end

    should "allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_response :unauthorized
    end


    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :unauthorized
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :unauthorized
    end
  end

  context "while authenticated as a director" do
    setup do
      @user = create(:director)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
      @request.headers["Authorization"] = Devise::JWT::TestHelpers.auth_headers(@request.headers, @user)["Authorization"]
    end

    should "allow access to manage_users#index" do
      get :index, format: :json
      assert_response :success
    end

    should "be able to reset a user's password" do
      assert_difference "enqueued_jobs.size", 1 do
        patch :reset_password, params: { id: @user }
      end
      assert :success
    end

    should "allow access to manage_users#show" do
      get :show, params: { id: @user }, format: :json
      assert_response :success
    end

    should "update user" do
      patch :update, params: { id: @user, user: { email: "test@example.coma" } }
      assert :success
    end

    should "destroy user" do
      assert_difference('User.count', -1) do
        patch :destroy, params: { id: @user }
      end
      assert :success
    end

    should "destroy user and user's questionnaire" do
      @questionnaire = create(:questionnaire, user_id: @user.id)
      assert_difference('Questionnaire.count', -1) do
        patch :destroy, params: { id: @user }
      end
      assert :success
    end
  end
end
