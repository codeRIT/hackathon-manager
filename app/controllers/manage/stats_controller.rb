class Manage::StatsController < Manage::ApplicationController
  before_action :require_director_or_organizer

  respond_to :html, :json

  def index
    dietary_restrictions_special_needs_restrictions = "acc_status = 'rsvp_confirmed' AND "\
    "dietary_restrictions != '' OR special_needs != ''"
    alt_travel_restrictions = "travel_not_from_school = '1'"
    sponsor_info_attendees_restrictions = "can_share_info = '1' AND checked_in_at != 0"

    @dietary_restrictions_special_needs_search = Questionnaire.ransack(params[:dietary_restrictions_special_needs_search], search_key: :dietary_restrictions_special_needs_search)
    @dietary_restrictions_special_needs = @dietary_restrictions_special_needs_search.result.includes(:user, :school, :bus_list).where(dietary_restrictions_special_needs_restrictions)
    @dietary_restrictions_special_needs_pagy, @dietary_restrictions_special_needs = pagy(@dietary_restrictions_special_needs, page_param: 'dietary_restrictions_special_needs_page', items: 10)

    @applied_search = Questionnaire.ransack(params[:applied_search], search_key: :applied_search)
    @applied = @applied_search.result.includes(:user, :school, :bus_list)
    @applied_pagy, @applied = pagy(@applied, page_param: 'applied_page', items: 10)

    @alt_travel_applicants_search = Questionnaire.ransack(params[:alt_travel_applicants_search], search_key: :alt_travel_applicants_search)
    @alt_travel_applicants = @alt_travel_applicants_search.result.includes(:user, :school, :bus_list).where(alt_travel_restrictions)
    @alt_travel_applicants_pagy, @alt_travel_applicants = pagy(@alt_travel_applicants, page_param: 'alt_travel_applicants_page', items: 10)

    @sponsor_info_attendees_search = Questionnaire.ransack(params[:sponsor_info_attendees_search], search_key: :sponsor_info_attendees_search)
    @sponsor_info_attendees = @sponsor_info_attendees_search.result.includes(:user, :school, :bus_list).where(sponsor_info_attendees_restrictions)
    @sponsor_info_attendees_pagy, @sponsor_info_attendees = pagy(@sponsor_info_attendees, page_param: 'sponsor_info_attendees_page', items: 10)
  end

  def checked_in_datatable
    render json: CheckedInDatatable.new(params, view_context: view_context)
  end
end
