class Manage::UsersController < Manage::ApplicationController
  before_action :require_director
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update, :reset_password, :destroy]
  before_action :find_user, only: [:show, :update, :reset_password, :destroy]

  respond_to :json

  def index
    @users = User.all
  end

  def reset_password
    new_password = Devise.friendly_token(50)
    if @user.reset_password(new_password, new_password)
      @user.send_reset_password_instructions
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @user.update_attributes(user_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    # used transaction so that if questionnaire is successfully deleted but
    # user deletion runs into a error the questionnaire deletion is rolled back
    User.transaction do
      if @user.destroy && (!@user.questionnaire.present? || @user.questionnaire.destroy)
        head :ok
      else
        head :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role, :is_active, :receive_weekly_report
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
