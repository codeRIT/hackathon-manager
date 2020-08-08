class Manage::IndividualMessagesController < Manage::ApplicationController
  before_action :set_message, only: [:show, :preview]

  respond_to :html, :json

  def index

  end

  def new
    user = User.find_by_id(params[:user_id])
    @individual_message = IndividualMessage.new
    @individual_message.user_id = params[:user_id]
    @individual_message.recipient = user.email
    @user_name = current_user.full_name
    @recipient = user.email
  end

  def create
    @individual_message = IndividualMessage.new(message_params)
    @individual_message.save
    if @individual_message.save
      @individual_message.update_attribute(:queued_at, Time.now)
      IndividualMessageJob.perform_later(@individual_message)
      redirect_to manage_users_path
    else
      render action => new, :id => @individual_message.user_id
    end
  end

  def datatable
    render json: IndividualMessageDatatable.new(params, view_context: view_context)
  end

  def preview
    email = UserMailer.individual_message(@individual_message.id)
    render html: email.body.raw_source.html_safe
  end


  def show
    respond_with(:manage, @message)
  end

  def update

  end

  def set_message
    @individual_message = IndividualMessage.find(params[:id])
  end

  def message_params
    params.require(:individual_message).permit(
      :name, :subject, :body, :recipient, :user_id
    )
  end
end
