class UsersController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  def show

  end

  def update
    if current_user.update_attributes(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :remember_me, :role, :is_active, :receive_weekly_report)
  end
end
