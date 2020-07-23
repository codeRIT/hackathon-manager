class Manage::IndividualMessageController < Manage::ApplicationController

  respond_to :html

  def index

  end

  def new
    user = User.find(params[:id])
    @individual_message = IndividualMessage.new
    @user_name = current_user.full_name
    @recipient = user.email
  end
  #
  # def create
  #   @message = IndividualMessage.new(message_params)
  #   @message.save
  # end

  def show

  end

  def update

  end

  def create

  end

  def message_params
    params.require(:individual_message).permit(
      :name, :subject, :body, :recipient,
    )
  end
end
