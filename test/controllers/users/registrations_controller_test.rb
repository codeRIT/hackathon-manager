require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @questionnaire = create(:questionnaire)
  end

  context "while authenticated with a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @questionnaire.user
    end

    should "destroy both user and questionnaire" do
      assert_difference('User.count', -1) do
        assert_difference('Questionnaire.count', -1) do
          delete :destroy, params: { id: @questionnaire.user }
        end
      end

      assert_redirected_to root_path
    end
  end

  context "when regirstion is disabled should redirect to root path" do
    HackathonConfig["disable_account_registration"] = true
    assert_redirected_to root_path
  end

  context "when regirstion occurs should redirect to questionnaire path" do
    HackathonConfig["disable_account_registration"] = false
    assert_redirected_to questionnaires_path
  end
end
