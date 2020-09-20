require 'test_helper'

class Manage::CheckinsControllerTest < ActionController::TestCase
  setup do
    @questionnaire = create(:questionnaire)
  end

  unauth_conditions = {
    'not authenticated' => false,
    'authenticated as a user' => true
  }

  unauth_conditions.each do |condition_name, do_sign_in|
    context "while #{condition_name}" do
      setup do
        if do_sign_in
          @user = create(:user)
          @request.env["devise.mapping"] = Devise.mappings[:director]
          sign_in @user
        end
      end

      should "not get index" do
        test_index_failure
      end

      should "not show checkin" do
        test_show_failure
      end

      should "not render checkin datatable" do
        test_datatable_failure
      end
    end
  end

  context "while not authenticated" do
    should "not render checkin datatable" do
      test_datatable_failure_401
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @user
    end

    should "not render checkin datatable" do
      test_datatable_failure
    end
  end

  success_conditions = {
    'volunteer' => :volunteer,
    'organizer' => :organizer,
    'director' => :director
  }

  success_conditions.each do |condition_name, user_role|
    context "while authenticated as a #{condition_name}" do
      setup do
        @user = create(:user, role: user_role)
        @request.env["devise.mapping"] = Devise.mappings[:director]
        sign_in @user
      end

      should "get index" do
        test_index_success
      end

      should "show checkin" do
        test_show_success
      end

      should "render checking datatable" do
        test_datatable_success
      end
    end
  end

  private

  # index
  def test_index_success
    get :index
    assert_response :success
  end

  def test_index_failure
    get :index
    assert_response :redirect
  end

  # show
  def test_show_success
    get :show, params: { id: @questionnaire.id }
    assert_response :success
  end

  def test_show_failure
    get :show, params: { id: @questionnaire.id }
    assert_response :redirect
  end

  # datatable
  def test_datatable_success
    post :datatable, format: :json, params: { "columns[0][data]" => "" }
    assert_response :success
  end

  def test_datatable_failure_401
    post :datatable, format: :json, params: { "columns[0][data]" => "" }
    assert_response 401
  end

  def test_datatable_failure
    post :datatable, format: :json, params: { "columns[0][data]" => "" }
    assert_response :redirect
  end
end
