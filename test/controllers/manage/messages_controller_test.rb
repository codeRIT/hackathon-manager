require "test_helper"

class Manage::MessagesControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  setup do
    @message = create(:message)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_messages#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response 401
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#show" do
      get :show, params: { id: @message }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, params: { id: @message }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#create" do
      post :create, params: { message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#update" do
      patch :update, params: { id: @message, message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#destroy" do
      patch :destroy, params: { id: @message }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not deliver message" do
      assert_difference("enqueued_jobs.size", 0) do
        patch :deliver, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#preview" do
      get :preview, params: { id: @message }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#live_preview" do
      get :live_preview, params: { body: "foo bar" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#duplicate" do
      assert_difference("Message.count", 0) do
        patch :duplicate, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#template" do
      test_template_failure
    end

    should "not allow access to manage_messages#template_preview" do
      test_template_preview_failure
    end

    should "not allow access to manage_messages#template_update" do
      test_template_update_failure
    end

    should "not allow access to manage_messages#template_replace_with_default" do
      test_template_replace_with_default_failure
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_messages#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#show" do
      get :show, params: { id: @message }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, params: { id: @message }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#create" do
      post :create, params: { message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#update" do
      patch :update, params: { id: @message, message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#destroy" do
      patch :destroy, params: { id: @message }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not deliver message" do
      assert_difference("enqueued_jobs.size", 0) do
        patch :deliver, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#preview" do
      get :preview, params: { id: @message }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#live_preview" do
      get :live_preview, params: { body: "foo bar" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#duplicate" do
      assert_difference("Message.count", 0) do
        patch :duplicate, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#template" do
      test_template_failure
    end

    should "not allow access to manage_messages#template_preview" do
      test_template_preview_failure
    end

    should "not allow access to manage_messages#template_update" do
      test_template_update_failure
    end

    should "not allow access to manage_messages#template_replace_with_default" do
      test_template_replace_with_default_failure
    end
  end

  context "while authenticated as an organizer" do
    setup do
      @user = create(:organizer)
      @request.env["devise.mapping"] = Devise.mappings[:director]
      sign_in @user
    end

    should "allow access to manage_messages#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_messages datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :success
    end

    should "allow access to manage_messages#show" do
      get :show, params: { id: @message }
      assert_response :success
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, params: { id: @message }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#create" do
      post :create, params: { message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#update" do
      patch :update, params: { id: @message, message: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#destroy" do
      patch :destroy, params: { id: @message }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not deliver message" do
      assert_difference("enqueued_jobs.size", 0) do
        patch :deliver, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "allow access to manage_messages#preview" do
      get :preview, params: { id: @message }
      assert_response :success
    end

    should "not allow access to manage_messages#live_preview" do
      get :live_preview, params: { body: "foo bar" }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#duplicate" do
      assert_difference("Message.count", 0) do
        patch :duplicate, params: { id: @message }
      end
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#template" do
      test_template_failure
    end

    should "not allow access to manage_messages#template_preview" do
      test_template_preview_failure
    end

    should "not allow access to manage_messages#template_update" do
      test_template_update_failure
    end

    should "not allow access to manage_messages#template_replace_with_default" do
      test_template_replace_with_default_failure
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:director)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_messages#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_messages#new" do
      get :new
      assert_response :success
    end

    should "create a new message" do
      post :create, params: { message: { type: "bulk", name: "New Message Name", subject: "Subject", recipients: ["abc"], body: "Example", trigger: "foo" } }
      assert_response :redirect
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "allow access to manage_messages#show" do
      get :show, params: { id: @message }
      assert_response :success
    end

    should "render manage_messages#show even if recipient is no longer valid" do
      message = create(:message, recipients: ["bus-list::9999"])
      get :show, params: { id: message }
      assert_response :success
    end

    should "allow access to manage_messages#edit" do
      get :edit, params: { id: @message }
      assert_response :success
    end

    should "update message" do
      patch :update, params: { id: @message, message: { name: "New Message Name", subject: "Subject", recipients: ["abc"], body: "Example", trigger: "bar" } }
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "deliver a bulk message" do
      assert_difference("enqueued_jobs.size", 1) do
        patch :deliver, params: { id: @message }
      end
      assert_match /queued/, flash[:notice]
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "not deliver an automated message" do
      @message.update_attribute(:type, "automated")
      assert_difference("enqueued_jobs.size", 0) do
        patch :deliver, params: { id: @message }
      end
      assert_match /cannot be manually delivered/, flash[:alert]
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "not allow multiple deliveries" do
      patch :deliver, params: { id: @message }
      assert_match /queued/, flash[:notice]
      patch :deliver, params: { id: @message }
      assert_match /cannot/, flash[:alert]
    end

    should "not be able to modify message after delivery" do
      @message.update_attribute(:delivered_at, 1.minute.ago)
      old_message_name = @message.name
      patch :update, params: { id: @message, message: { name: "New Message Name" } }
      assert_match /can no longer/, flash[:alert]
      assert_equal old_message_name, @message.reload.name
    end

    should "destroy message" do
      assert_difference("Message.count", -1) do
        patch :destroy, params: { id: @message }
      end
      assert_redirected_to manage_messages_path
    end

    should "allow access to manage_messages#preview" do
      get :preview, params: { id: @message }
      assert_response :success
    end

    should "allow access to manage_messages#live_preview" do
      get :live_preview, params: { body: "foo bar" }
      assert_response :success
    end

    should "not error with unset body on manage_messages#live_preview" do
      get :live_preview
      assert_response :success
    end

    should "render markdown in manage_messages#preview" do
      @message.update_attribute(:body, "### This is a title")
      get :preview, params: { id: @message }
      assert_response :success
      assert_select "h3", "This is a title"
    end

    should "render html in manage_messages#preview" do
      @message.update_attribute(:body, "<h3>This is a title</h3>")
      get :preview, params: { id: @message }
      assert_response :success
      assert_select "h3", "This is a title"
    end

    should "render template variables in manage_messages#preview" do
      @message.update_attribute(:body, "### Hello, {{first_name}}!")
      get :preview, params: { id: @message }
      assert_response :success
      assert_select "h3", "Hello, John!"
    end

    should "render template variables in manage_messages#live_preview" do
      get :live_preview, params: { body: "### {{first_name}} {{last_name}}" }
      assert_response :success
      assert_select "h3", "John Smith"
    end

    context "manage_messages#duplicate" do
      should "duplicate message" do
        assert_difference("Message.count", 1) do
          patch :duplicate, params: { id: @message }
        end
        assert_response :redirect
        assert_redirected_to edit_manage_message_path(Message.last)
      end

      should "reset status" do
        @message.update_attributes(
          delivered_at: Time.now,
          started_at: Time.now,
          queued_at: Time.now,
        )
        patch :duplicate, params: { id: @message }
        assert_equal "drafted", Message.last.status
      end

      should "maintain similar fields" do
        @message.update_attributes(
          name: "My message name",
          subject: "This subject",
          body: "hello world",
        )
        patch :duplicate, params: { id: @message }
        assert_equal "Copy of My message name", Message.last.name
        assert_equal "This subject", Message.last.subject
        assert_equal "hello world", Message.last.body
      end
    end

    should "allow access to manage_messages#template" do
      get :template
      assert_response :success
    end

    should "allow access to manage_messages#template_preview" do
      test_template_preview_success
    end

    should "allow access to manage_messages#template_update" do
      test_template_update_success
    end

    should "allow access to manage_messages#template_replace_with_default" do
      test_template_replace_with_default_success
    end
  end

  private

  def test_template_failure
    get :template
    assert_response :redirect
  end

  def test_template_success
    get :template
    assert_response :success
    assert_select "h1", "Message template"
  end

  def test_template_preview_failure
    get :template_preview
    assert_response :redirect
  end

  def test_template_preview_success
    get :template_preview
    assert_response :success
    assert_select "h1", "This is an h1"
  end

  def test_template_update_failure
    MessageTemplate.load_singleton
    patch :template_update, params: { message_template: { html: "foo" } }
    assert_not_equal "foo", MessageTemplate.uncached_instance.html, "should not replace contents"
    assert_response :redirect
  end

  def test_template_update_success
    MessageTemplate.load_singleton
    patch :template_update, params: { message_template: { html: "foo" } }
    assert_equal "foo", MessageTemplate.uncached_instance.html, "should replace contents"
    assert_response :redirect
    MessageTemplate.replace_with_default # clean up
  end

  def test_template_replace_with_default_failure
    MessageTemplate.load_singleton
    MessageTemplate.instance.update_attribute(:html, "foo")
    post :template_replace_with_default
    assert_equal "foo", MessageTemplate.uncached_instance.html, "should not replace contents"
    assert_response :redirect
    MessageTemplate.replace_with_default # clean up
  end

  def test_template_replace_with_default_success
    MessageTemplate.load_singleton
    MessageTemplate.instance.update_attribute(:html, "foo")
    post :template_replace_with_default
    assert_not_equal "foo", MessageTemplate.uncached_instance.html, "should replace contents"
    assert_response :redirect
    MessageTemplate.replace_with_default # clean up
  end
end
