class Manage::EventsController < Manage::ApplicationController
  before_action :require_director
  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: Event.all }
    end
  end

  def new
    @event = ::Event.new
  end

  def create
    @event = ::Event.new(event_params)
    if @event.save
      redirect_to(manage_events_path)
    else
      render('new')
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    respond_with(:manage, @event)
  end

  def update
    @event = Event.find_by_id(params[:id])
    if @event.update(event_params)
      redirect_to(manage_events_path)
    else
      render('show')
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if @event.destroy
      redirect_to(manage_events_path)
    else
      render('show')
    end
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :location, :public, :start, :finish, owner: []
    )
  end
end
