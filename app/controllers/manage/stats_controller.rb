class Manage::StatsController < Manage::ApplicationController
  before_action :require_director_or_organizer

  respond_to :html, :json

  def index
    dietary_restrictions_special_needs_restrictions = "acc_status = 'rsvp_confirmed' AND "\
    "dietary_restrictions != '' OR special_needs != ''"

    @dietary_restrictions_special_needs_search = Questionnaire.ransack(params[:dietary_restrictions_special_needs_search], search_key: :dietary_restrictions_special_needs_search)
    @dietary_restrictions_special_needs = @dietary_restrictions_special_needs_search.result.includes(:user, :school, :bus_list).where(dietary_restrictions_special_needs_restrictions)
    @dietary_restrictions_special_needs_pagy, @dietary_restrictions_special_needs = pagy(@dietary_restrictions_special_needs, page_param: 'dietary_restrictions_special_needs_page', items: 10)

    @applied_search = Questionnaire.ransack(params[:applied_search], search_key: :applied_search)
    @applied = @applied_search.result.includes(:user, :school, :bus_list)
    @applied_pagy, @applied = pagy(@applied, page_param: 'applied_page', items: 10)
  end

  def alt_travel_datatable
    render json: AltTravelDatatable.new(params, view_context: view_context)
  end

  def attendee_sponsor_info_datatable
    render json: AttendeeSponsorInfoDatatable.new(params, view_context: view_context)
  end

  def checked_in_datatable
    render json: CheckedInDatatable.new(params, view_context: view_context)
  end
end
