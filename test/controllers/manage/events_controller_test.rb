require "test_helper"

class Manage::EventsControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @event = create(:event)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_events#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_events#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_events#show" do
      get :show, params: { id: @event }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_events#create" do
      post :create, params: { event: { title: "should not exist title" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_events#update" do
      patch :update, params: { id: @event, title: "not allowed altered title" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_events#destroy" do
      patch :destroy, params: { id: @event }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      sign_in @user
    end

    should "not allow access to manage_events#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#show" do
      get :show, params: {id: @event}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#create" do
      post :create, params: {event: {title: "should not exist title"}}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#update" do
      patch :update, params: {id: @event, title: "not allowed altered title"}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#destroy" do
      patch :destroy, params: {id: @event}
      assert_response :redirect
      assert_redirected_to root_path
    end

  end

  context "while authenticated as a limited access admin" do
    setup do
      @user = create(:limited_access_admin)
      sign_in @user
    end

    should "not allow access to manage_events#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#show" do
      get :show, params: {id: @event}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#create" do
      post :create, params: {event: {title: "should not exist title"}}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#update" do
      patch :update, params: {id: @event, title: "not allowed altered title"}
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_events#destroy" do
      patch :destroy, params: {id: @event}
      assert_response :redirect
      assert_redirected_to root_path
    end

  end

  context "while authenticated as a admin" do
    setup do
      @user = create(:admin)
      sign_in @user
    end

    should "allow access to manage_events#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_events#new" do
      get :new
      assert_response :success
    end

    should "allow access to manage_events#show" do
      get :show, params: { id: @event }
      assert_response :success
    end

    should "allow access to manage_events#create" do
      post :create, params: { event: {title: "test new title", start: Date.today - 1.hour, finish: Date.today}}
      assert_redirected_to manage_event_path(assigns(:event))

    end

    should "allow access to manage_events#update" do
      patch :update, params: { id: @event, event: {title: "test update title"}}
      assert_redirected_to manage_bus_list_path(assigns(:event))
    end

    should "allow access to manage_events#destroy" do
      patch :destroy, params: {id: @event}
      assert_response :redirect
      assert_redirected_to manage_events_path
    end

  end
end
