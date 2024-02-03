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
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @user
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
end
