require 'test_helper'

class Manage::UsersControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_users#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_users user datatables api" do
      post :user_datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response 401
    end

    should "not allow access to manage_users staff datatables api" do
      post :staff_datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response 401
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

    should "not allow access to manage_users users datatables api" do
      post :user_datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_users staff datatables api" do
      post :staff_datatable, format: :json, params: { "columns[0][data]" => "" }
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

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:staff]
      sign_in @user
    end

    should "not allow access to manage_users#index" do
      get :index
      assert_redirected_to root_path
    end

    should "not allow access to manage_users users datatables api" do
      post :user_datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_redirected_to root_path
    end

    should "not allow access to manage_users staff datatables api" do
      post :staff_datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_redirected_to root_path
    end

    should "allow access to manage_users#show" do
      get :show, params: { id: @user }
      assert_redirected_to root_path
    end

    should "not allow access to manage_users#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_users_path
    end

    should "not allow access to manage_users#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :redirect
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

    # TODO: Tests appear to be stalling Travis CI

    # should "create a new admin" do
    #   post :create, params: { user: { email: "test@example.com", role: 'admin' } }
    #   assert_response :redirect
    #   assert_redirected_to manage_users_path
    #   assert assigns(:user).admin?, "new user should be an admin"
    # end

    # should "create a new limited access admin" do
    #   post :create, params: { user: { email: "test@example.com", role: 'admin_limited_access' } }
    #   assert_response :redirect
    #   assert_redirected_to manage_users_path
    #   assert !assigns(:user).admin?, "new user should not be an admin"
    #   assert assigns(:user).admin_limited_access?, "new user should be a limited access admin"
    # end

    # should "not create an admin with duplicate emails" do
    #   create(:user, email: "existing@example.com")
    #   assert_difference('User.count', 0) do
    #     post :create, params: { user: { email: "existing@example.com", role: 'admin' } }
    #   end
    # end

    # should "allow access to manage_admins#new" do
    #   get :new, params: { id: @user }
    #   assert_response :success
    # end

    # should "allow access to manage_admins#show" do
    #   get :show, params: { id: @user }
    #   assert_response :success
    # end

    # should "allow access to manage_admins#edit" do
    #   get :edit, params: { id: @user }
    #   assert_response :success
    # end

    # should "update user" do
    #   patch :update, params: { id: @user, user: { email: "test@example.coma" } }
    #   assert_redirected_to manage_users_path
    # end

    # should "destroy user" do
    #   assert_difference('User.count', -1) do
    #     patch :destroy, params: { id: @user }
    #   end
    #   assert_redirected_to manage_users_path
    # end
  end
end
