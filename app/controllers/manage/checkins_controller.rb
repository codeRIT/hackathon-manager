class Manage::CheckinsController < Manage::ApplicationController
  before_action :set_questionnaire, only: [:show]

  respond_to :html, :json

  def index
    respond_with(:manage, Questionnaire.all)
  end

  def datatable
    render json: CheckinDatatable.new(view_context)
  end

  def show
    respond_with(:manage, @questionnaire)
  end

  private

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end
end
