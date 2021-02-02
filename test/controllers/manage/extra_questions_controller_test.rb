require 'test_helper'

class Manage::ExtraQuestionsControllerTest < ActionController::TestCase
  setup do
    @extra_question = create(:extra_question)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_extra_questions#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_extra_questions#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_extra_questions#show" do
      get :show, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_extra_questions#create" do
      post :create, params: { extra_question: { question: "should not exist title" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_extra_questions#update" do
      patch :update, params: { id: @extra_question, question: "should not exist title" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_extra_questions#destroy" do
      patch :destroy, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as an user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_extra_questions#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_extra_questions#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_extra_questions#show" do
      get :show, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_extra_questions#create" do
      post :create, params: { extra_question: { question: "should not exist title" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_extra_questions#update" do
      patch :update, params: { id: @extra_question, question: "should not exist title" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_extra_questions#destroy" do
      patch :destroy, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  context "while authenticated as an volunteer" do
    setup do
      @user = create(:volunteer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_extra_questions#index" do
      get :index
      assert_response :redirect
      assert_redirected_to manage_checkins_path
    end

    should "not allow access to manage_extra_questions#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#show" do
      get :show, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to manage_checkins_path
    end

    should "not allow access to manage_extra_questions#create" do
      post :create, params: { extra_question: { question: "should not exist title" } }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#update" do
      patch :update, params: { id: @extra_question, question: "should not exist title" }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#destroy" do
      patch :destroy, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end
  end

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_extra_questions#index" do
      get :index
      assert_response :redirect
      assert_redirected_to manage_root_path
    end

    should "not allow access to manage_extra_questions#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#show" do
      get :show, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to manage_root_path
    end

    should "not allow access to manage_extra_questions#create" do
      post :create, params: { extra_question: { question: "should not exist title" } }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#update" do
      patch :update, params: { id: @extra_question, question: "should not exist title" }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#destroy" do
      patch :destroy, params: { id: @extra_question }
      assert_response :redirect
      assert_redirected_to manage_extra_questions_path
    end
  end

  context "while authenticated as an director" do
    setup do
      @user = create(:director)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_extra_questions#index" do
      get :index
      assert_response :success
    end

    should "not allow access to manage_extra_questions#new" do
      get :new
      assert_response :success
    end

    should "not allow access to manage_extra_questions#show" do
      get :show, params: { id: @extra_question }
      assert_response :success
    end

    should "not allow access to manage_extra_questions#create" do
      post :create, params: { extra_question: { question: "should exist title", data_type: "boolean" } }
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#update" do
      patch :update, params: { id: @extra_question, extra_question: { question: "should exist title" } }
      assert_redirected_to manage_extra_questions_path
    end

    should "not allow access to manage_extra_questions#destroy" do
      patch :destroy, params: { id: @extra_question }
      assert_redirected_to manage_extra_questions_path
    end
  end
end
