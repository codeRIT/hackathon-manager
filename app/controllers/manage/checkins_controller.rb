class Manage::CheckinsController < Manage::ApplicationController
  before_action :set_questionnaire, only: [:show]
  helper_method :about

  respond_to :html, :json

  def index
    @applicants_search = Questionnaire.ransack(params[:applicants_search], search_key: :applicants_search)
    @applicants = @applicants_search.result.includes(:user, :school, :bus_list)
    @applicants_pagy, @applicants = pagy(@applicants, page_param: 'applicants_page', items: 10)
  end

  def about(record)
    output = ""
    output += [record.user.first_name, record.user.last_name].join(" ") + " "
    output += '<span class="badge badge-warning"><i class="fa fa-exclamation-triangle"></i>Minor</span>' if record.minor?
    output += "<br /><small>" + record.school.name + "</small>"
    output.html_safe
  end

  def show
    @agreements = Agreement.all
    respond_with(:manage, @questionnaire)
  end

  private

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end
end
