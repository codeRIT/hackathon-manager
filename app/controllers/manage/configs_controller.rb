class Manage::ConfigsController < Manage::ApplicationController
  before_action :limit_access_admin

  respond_to :html, :json

  def show
    respond_with(Rails.configuration.hackathon)
  end

  private

  def limit_access_admin
    redirect_to manage_root_path if current_user.admin_limited_access
  end
end
