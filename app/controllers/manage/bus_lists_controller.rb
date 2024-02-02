class Manage::BusListsController < Manage::ApplicationController
  before_action :set_bus_list, only: [:show, :edit, :update, :destroy, :toggle_bus_captain, :send_update_email]

  respond_to :html, :json

  def index
    @bus_list_search = BusList.ransack(params[:bus_list_search], search_key: :bus_list_search)
    @bus_lists = @bus_list_search.result(distinct: true)
    @bus_list_pagy, @bus_lists = pagy(@bus_lists, page_param: 'bus_list_page', items: 10)
  end

  def show
    @questionnaires_search = Questionnaire.ransack(params[:questionnaires_search], search_key: :questionnaires_search)
    @questionnaires = @questionnaires_search.result.includes(:user, :school, :bus_list).where(bus_list_id: @bus_list.id)
    @questionnaires_pagy, @questionnaires = pagy(@questionnaires, page_param: 'questionnaire_page', items: 10)
    respond_with(:manage, @bus_list)
  end

  def new
    @bus_list = BusList.new
    respond_with(:manage, @bus_list)
  end

  def edit
  end

  def create
    @bus_list = BusList.new(bus_list_params)
    @bus_list.save
    respond_with(:manage, @bus_list)
  end

  def update
    @bus_list.update(bus_list_params)
    respond_with(:manage, @bus_list)
  end

  def destroy
    Questionnaire.where(bus_list_id: @bus_list.id).each do |questionnaire|
      questionnaire.update_attribute(:bus_list_id, nil)
    end
    @bus_list.destroy
    respond_with(:manage, @bus_list)
  end

  def toggle_bus_captain
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    is_bus_captain = params[:bus_captain] == "1"
    @questionnaire.update_attribute(:is_bus_captain, is_bus_captain)
    if @questionnaire.reload.is_bus_captain
      flash[:notice] = "#{@questionnaire.user.full_name} has been promoted to a bus captain."
      Message.queue_for_trigger("bus_list.new_captain_confirmation", @questionnaire.user.id)
    else
      flash[:notice] = "#{@questionnaire.user.full_name} has been removed as a bus captain."
    end
    redirect_to [:manage, @bus_list]
  end

  def send_update_email
    if Message.for_trigger("bus_list.notes_update").empty?
      flash[:alert] = "Error: No automated message is configured for bus note updates!"
      redirect_to [:manage, @bus_list]
      return
    end

    @bus_list.passengers.each do |passenger|
      Message.queue_for_trigger("bus_list.notes_update", passenger.id).count
    end
    flash[:notice] = "Bus notes update emails have been sent"
    redirect_to [:manage, @bus_list]
  end

  private

  def bus_list_params
    params.require(:bus_list).permit(
      :name, :capacity, :notes, :needs_bus_captain
    )
  end

  def set_bus_list
    @bus_list = BusList.find(params[:id])
  end
end
