class Manage::UsersController < Manage::ApplicationController
  before_action :limit_write_access_to_directors, only: ["edit", "update", "destroy"]
  before_action :require_director
  before_action :find_user, only: [:show, :edit, :update, :reset_password, :destroy]

  respond_to :html, :json

  def index
    @user_search = User.ransack(params[:user_search], search_key: :user_search)
    @users = @user_search.result(distinct: true)
    @user_pagy, @users = pagy(@users, page_param: 'user_page', items: 10)

    @staff_search = User.ransack(params[:staff_search], search_key: :staff_search)
    @staff = @staff_search.result(distinct: true).staff
    @staff_pagy, @staff = pagy(@staff, page_param: 'staff_page', items: 10)
  end

  def reset_password
    new_password = Devise.friendly_token(50)
    @user.reset_password(new_password, new_password)
    @user.send_reset_password_instructions
    flash[:notice] = t(:reset_password_success, scope: 'pages.manage.users.edit', full_name: @user.full_name)
    respond_with(:manage, @user, location: manage_users_path)
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
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
      :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role, :is_active, :receive_weekly_report
    )
  end

  def find_user
    @user = ::User.find(params[:id])
  end
end
