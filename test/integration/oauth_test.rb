require 'test_helper'

class OauthTest < ActionDispatch::IntegrationTest
  setup do
    @application = create(:application) # OAuth application
    @questionnaire = create(:questionnaire)
    @user = @questionnaire.user
  end

  context "access without API key" do
    should "error on questionnaire data" do
      get questionnaires_path, headers: json_headers
      assert_response :unauthorized
    end
  end

  context "access with invalid API key" do
    setup do
      @token = create(:access_token, application: @application, resource_owner_id: @user.id)
      @application.destroy
    end

    should "not return data for questionnaire" do
      get questionnaires_path, headers: auth_headers(@token.token)
      assert_response :redirect
      assert_redirected_to new_user_session_url
    end
  end

  context "access with API key" do
    setup do
      @token = create(:access_token, application: @application, resource_owner_id: @user.id)
    end

    should "return data for questionnaire" do
      get '/users/auth/mlh', params: { format: :json }, headers: auth_headers(@token.token)
      assert_response :success
    end
  end

  private

  def json_headers
    {
      content_type: 'application/json'
    }
  end

  def auth_headers(token)
    {
      content_type: 'application/json',
      authorization: "Bearer #{token}"
    }
  end
end
