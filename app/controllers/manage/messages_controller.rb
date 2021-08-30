class Manage::MessagesController < Manage::ApplicationController
  before_action :require_director_or_organizer
  before_action :set_message, only: [:show, :update, :destroy, :deliver, :preview, :duplicate]
  before_action :check_message_access, only: [:edit, :update, :destroy]
  before_action :limit_template_access_to_directors, only: [:template, :template_preview, :template_update, :template_replace_with_default]

  respond_to :json

  def index
    @messages = Message.all
  end

  def show
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def update
    if @message.update_attributes(message_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if @message.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def deliver
    if @message.automated?
      render json: ErrorResponse.new(:messages_deliever_cannotDeliverAutomated), status: :bad_request
      return
    end
    if @message.status != "drafted"
      render json: ErrorResponse.new(:messages_deliever_cannotDeliverNonDrafted), status: :bad_request
      return
    end
    @message.update_attribute(:queued_at, Time.now)
    BulkMessageJob.perform_later(@message)
    head :ok
  end

  def preview
    email = UserMailer.bulk_message_email(@message.id, current_user.id, nil, true)
    render html: email.body.raw_source.html_safe
  end

  def live_preview
    body = params[:body] || ""
    message = Message.new(body: body)
    email = UserMailer.bulk_message_email(nil, current_user.id, message, true)
    render html: email.body.raw_source.html_safe
  end

  def duplicate
    new_message = @message.dup
    new_message.update_attributes(
      delivered_at: nil,
      started_at: nil,
      queued_at: nil,
      name: "Copy of #{@message.name}",
    )

    if new_message.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def template
  end

  def template_preview
    body = File.read("app/views/manage/messages/_template_example.html.md")
    message = Message.new(body: body)
    email = UserMailer.bulk_message_email(nil, current_user.id, message, true)
    render html: email.body.raw_source.html_safe
  end

  def template_update
    message_template = MessageTemplate.uncached_instance
    message_template_params = params.require(:message_template).permit(:html)

    if message_template.update_attributes(message_template_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def template_replace_with_default
    MessageTemplate.replace_with_default
    head :ok
  end

  private

  def limit_template_access_to_directors
    # From Manage::ApplicationController
    limit_write_access_to_directors
  end

  def message_params
    params.require(:message).permit(
      :type, :name, :subject, :template, :body, :trigger, recipients: [],
    )
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def check_message_access
    return if @message.can_edit?

    flash[:alert] = "Message can no longer be modified"
    redirect_to manage_message_path(@message)
  end
end
