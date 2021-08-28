load 'lib/v3/error_response.rb'

class Manage::ApplicationController < ApplicationController
  before_action :logged_in
  before_action :require_director_or_organizer_or_volunteer
  before_action :limit_write_access_to_directors, only: ["edit", "update", "new", "create", "destroy", "deliver", "merge", "perform_merge", "toggle_bus_captain", "duplicate", "update_acc_status", "send_update_email", "live_preview"]
  skip_before_action :verify_authenticity_token, if: :json_request?

  def logged_in
    authenticate_user!
  end

  def require_director
    return head :unauthorized if current_user.volunteer?
    return redirect_to manage_root_path if current_user.organizer?
    return redirect_to root_path unless current_user.try(:director?)
  end

  def require_director_or_organizer
    return head :unauthorized if current_user.volunteer?
    return redirect_to root_path unless current_user.organizing_staff?
  end

  def require_director_or_organizer_or_volunteer
    redirect_to root_path unless current_user.staff?
  end

  def limit_write_access_to_directors
    redirect_to url_for(controller: controller_name, action: :index) unless current_user.try(:director?)
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
