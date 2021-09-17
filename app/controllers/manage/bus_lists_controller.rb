class Manage::BusListsController < Manage::ApplicationController
  before_action :set_bus_list, only: [:show, :update, :destroy, :toggle_bus_captain, :send_update_email]

  respond_to :json

  def index
    @bus_lists = BusList.all
  end

  def show
  end

  def create
    @bus_list = BusList.new(bus_list_params)
    if @bus_list.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def update
    if @bus_list.update_attributes(bus_list_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    Questionnaire.where(bus_list_id: @bus_list.id).each do |questionnaire|
      questionnaire.update_attribute(:bus_list_id, nil)
    end
    if @bus_list.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def toggle_bus_captain
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    is_bus_captain = params[:bus_captain] == "1"
    @questionnaire.update_attribute(:is_bus_captain, is_bus_captain)
    if @questionnaire.reload.is_bus_captain
      Message.queue_for_trigger("bus_list.new_captain_confirmation", @questionnaire.user.id)
    end
    head :ok
  end

  def send_update_email
    if Message.for_trigger("bus_list.notes_update").empty?
      render json: ErrorResponse.new(:busLists_sendUpdateEmail_NotesEmpty), status: :unprocessable_entity
      return
    end

    @bus_list.passengers.each do |passenger|
      Message.queue_for_trigger("bus_list.notes_update", passenger.id).count
    end
    head :ok
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
