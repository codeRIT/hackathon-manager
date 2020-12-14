class Manage::StatsController < Manage::ApplicationController
  before_action :require_director_or_organizer

  respond_to :html, :json

  def dietary_restrictions_special_needs_datatable
    render json: DietarySpecialNeedsDatatable.new(params, view_context: view_context)
  end

  def alt_travel_datatable
    render json: AltTravelDatatable.new(params, view_context: view_context)
  end

  def attendee_sponsor_info_datatable
    render json: AttendeeSponsorInfoDatatable.new(params, view_context: view_context)
  end

  def applied_datatable
    render json: AppliedDatatable.new(params, view_context: view_context)
  end

  def checked_in_datatable
    render json: CheckedInDatatable.new(params, view_context: view_context)
  end
end
