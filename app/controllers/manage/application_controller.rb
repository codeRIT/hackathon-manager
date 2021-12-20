load 'lib/v3/error_response.rb'

class Manage::ApplicationController < ApplicationController
  before_action :require_director_or_organizer_or_volunteer
  before_action :limit_write_access_to_directors, only: ["edit", "update", "new", "create", "destroy", "deliver", "merge", "perform_merge", "toggle_bus_captain", "duplicate", "update_acc_status", "send_update_email", "live_preview"]
  skip_before_action :verify_authenticity_token, if: :json_request?

  def require_director
    return head :unauthorized unless current_user.director?
  end

  def require_director_or_organizer
    return head :unauthorized unless current_user.organizing_staff?
  end

  def require_director_or_organizer_or_volunteer
    return head :unauthorized unless current_user.staff?
  end

  def limit_write_access_to_directors
    return head :unauthorized unless current_user.director?
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
