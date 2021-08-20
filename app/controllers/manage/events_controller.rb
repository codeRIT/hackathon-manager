class Manage::EventsController < Manage::ApplicationController
  before_action :require_director_or_organizer, only: :index
  before_action :require_director, except: :index
  before_action :set_event, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @events = Event.all
  end

  def create
    @event = ::Event.new(event_params)
    if @event.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @event.update(event_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :location, :category, :start, :finish
    )
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
