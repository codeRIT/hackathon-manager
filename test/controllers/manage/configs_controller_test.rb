require "test_helper"

class Manage::ConfigsControllerTest < ActionController::TestCase
  context "while not authenticated" do
    should "redirect to sign in page on manage_configs#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_configs#edit" do
      get :edit, params: { id: "registration_is_open" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not update config" do
      HackathonConfig["registration_is_open"] = false
      patch :update, params: { id: "registration_is_open", hackathon_config: { registration_is_open: "true" } }
      assert_equal false, HackathonConfig["registration_is_open"]
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "not allow access to manage_configs#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_configs#edit" do
      get :edit, params: { id: "registration_is_open" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not update config" do
      HackathonConfig["registration_is_open"] = false
      patch :update, params: { id: "registration_is_open", hackathon_config: { registration_is_open: "true" } }
      assert_equal false, HackathonConfig["registration_is_open"]
      assert_redirected_to root_path
    end
  end

  context "while authenticated as a limited access admin" do
    setup do
      @user = create(:limited_access_admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "not allow access to manage_configs#index" do
      get :index
      assert_response :redirect
    end

    should "not allow access to manage_configs#edit" do
      get :edit, params: { id: "registration_is_open" }
      assert_response :redirect
    end

    should "not update config" do
      HackathonConfig["registration_is_open"] = false
      patch :update, params: { id: "registration_is_open", hackathon_config: { registration_is_open: "true" } }
      assert_equal false, HackathonConfig["registration_is_open"]
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "allow access to manage_configs#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_configs#edit" do
      get :edit, params: { id: "registration_is_open" }
      assert_response :success
    end

    should "update config" do
      HackathonConfig["registration_is_open"] = false
      patch :update, params: { id: "registration_is_open", hackathon_config: { registration_is_open: "true" } }
      assert_equal true, HackathonConfig["registration_is_open"]
      assert_redirected_to manage_configs_path
    end
  end
end
