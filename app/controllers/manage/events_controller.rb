class Manage::EventsController < Manage::ApplicationController

  respond_to :html, :json

  def index
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: Event.all }
    end
  end

  def new
    @event = ::Event.new
    respond_with(:manage, @event)
  end

  def create
    @event = ::Event.new(event_params)
    @event.save
    respond_with(:manage, @event)
  end

  def show
  end

  def edit
  end

  def update
    @event.update_attributes(event_params)
    respond_with(:manage, @event)
  end

  def destroy

  end

  def event_params
    params.require(:event).permit(
        :title, :description, :owner, :allDay, :start, :end,
        )
  end
end
