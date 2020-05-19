class Manage::UsersController < Manage::ApplicationController
  before_action :require_full_admin
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  
  def index
    respond_with(:manage, User.where(role: [:admin, :admin_limited_access, :event_tracking]))
  end
  
  def user_datatable
    render json: UserDatatable.new(params, view_context: view_context)
  end

  def admin_datatable
    render json: AdminDatatable.new(params, view_context: view_context)
  end

  def show
    respond_with(:manage, @user)
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    respond_with(:manage, @user, location: manage_users_path)
  end

  def destroy
    if @user.questionnaire.present?
      @user.questionnaire.destroy
    end
    @user.destroy
    respond_with(:manage, @user, location: manage_users_path)
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :remember_me, :role, :is_active, :receive_weekly_report
    )
  end

  def find_user
    @user = ::User.find(params[:id])
  end
end
