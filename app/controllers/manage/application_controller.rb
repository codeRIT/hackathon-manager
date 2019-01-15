class Manage::ApplicationController < ApplicationController
  before_action :logged_in
  before_action :limit_admin_access, only: ["edit", "update", "new", "create", "destroy", "convert_to_admin", "deliver", "merge", "perform_merge", "toggle_bus_captain", "duplicate", "update_acc_status", "send_update_email", "live_preview"]
  skip_before_action :verify_authenticity_token, if: :json_request?

  def logged_in
    authenticate_user!
    return redirect_to root_path unless current_user.try(:admin?)
  end

  def limit_admin_access
    redirect_to url_for(controller: controller_name, action: :index) if current_user.admin_limited_access
  end

  def json_request?
    request.format.json?
  end

  def response_view_or_errors(view, model)
    respond_to do |format|
      format.html { render(view) }
      format.json { render json: { errors: model.errors.full_messages } }
    end
  end
end
