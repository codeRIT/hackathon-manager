require 'test_helper'

class Manage::DataExportsControllerTest < ActionController::TestCase
  setup do
    @data_export = create(:data_export)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_data_exports#index" do
      get :index, as: :json
      assert_response :unauthorized
    end

    should "not allow access to manage_data_exports#create" do
      post :create, params: { export_type: "sponsor_dump_rsvp_confirmed" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_data_exports#destroy" do
      patch :destroy, params: { id: @data_export }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end
end
