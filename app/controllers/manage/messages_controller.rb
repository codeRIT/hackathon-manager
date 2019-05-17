class Manage::MessagesController < Manage::ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :deliver, :preview, :duplicate]
  before_action :check_message_access, only: [:edit, :update, :destroy]

  respond_to :html, :json

  def index
    respond_with(:manage, Message.all)
  end

  def datatable
    render json: BulkMessageDatatable.new(view_context)
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
      flash[:error] = "Automated messages cannot be manually delivered. Only bulk messages can."
      return redirect_to manage_message_path(@message)
    end
    if @message.status != "drafted"
      flash[:error] = "Message cannot be re-delivered"
      return redirect_to manage_messages_path
    end
    @message.update_attribute(:queued_at, Time.now)
    BulkMessageWorker.perform_async(@message.id)
    flash[:notice] = "Message queued for delivery"
    redirect_to manage_message_path(@message)
  end

  def preview
    email = Mailer.bulk_message_email(@message.id, current_user.id, nil, true)
    render html: email.body.raw_source.html_safe
  end

  def live_preview
    body = params[:body] || ''
    message = Message.new(body: body)
    email = Mailer.bulk_message_email(nil, current_user.id, message, true)
    render html: email.body.raw_source.html_safe
  end

  def duplicate
    new_message = @message.dup
    new_message.update_attributes(
      delivered_at: nil,
      started_at: nil,
      queued_at: nil,
      name: "Copy of #{@message.name}"
    )
    new_message.save
    redirect_to edit_manage_message_path(new_message.reload)
  end

  private

  def message_params
    params.require(:message).permit(
      :type, :name, :subject, :template, :body, :trigger, recipients: []
    )
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def check_message_access
    return if @message.can_edit?

    flash[:error] = "Message can no longer be modified"
    redirect_to manage_message_path(@message)
  end
end
