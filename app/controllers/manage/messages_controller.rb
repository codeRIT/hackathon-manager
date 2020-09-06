class Manage::MessagesController < Manage::ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :deliver, :preview, :duplicate]
  before_action :check_message_access, only: [:edit, :update, :destroy]
  before_action :limit_template_access_to_directors, only: [:template, :template_preview, :template_update, :template_replace_with_default]

  respond_to :html, :json

  def index
    respond_with(:manage, Message.all)
  end

  def datatable
    render json: BulkMessageDatatable.new(params, view_context: view_context)
  end

  def show
    respond_with(:manage, @message)
  end

  def new
    type = params[:type]
    recipients = params[:recipients]
    @message = Message.new(type: type, recipients: recipients)
    respond_with(:manage, @message)
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.save
    respond_with(:manage, @message)
  end

  def update
    @message.update_attributes(message_params)
    respond_with(:manage, @message)
  end

  def destroy
    @message.destroy
    respond_with(:manage, @message)
  end

  def deliver
    if @message.automated?
      flash[:alert] = "Automated messages cannot be manually delivered. Only bulk messages can."
      return redirect_to manage_message_path(@message)
    end
    if @message.status != "drafted"
      flash[:alert] = "Message cannot be re-delivered"
      return redirect_to manage_messages_path
    end
    @message.update_attribute(:queued_at, Time.now)
    BulkMessageJob.perform_later(@message)
    flash[:notice] = "Message queued for delivery"
    redirect_to manage_message_path(@message)
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
    new_message.save
    redirect_to edit_manage_message_path(new_message.reload)
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
    message_template.update_attributes(message_template_params)
    redirect_to template_manage_messages_path
  end

  def template_replace_with_default
    MessageTemplate.replace_with_default
    redirect_to template_manage_messages_path
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
