class Manage::TrackableEventsController < Manage::ApplicationController
  before_action :set_trackable_event, only: [:show, :edit, :update, :destroy]

  # GET /trackable_events
  def index
    @trackable_events = TrackableEvent.all
  end

  # GET /trackable_events/1
  def show
  end

  # GET /trackable_events/new
  def new
    @trackable_event = TrackableEvent.new
  end

  # GET /trackable_events/1/edit
  def edit
  end

  # POST /trackable_events
  def create
    @trackable_event = TrackableEvent.new(trackable_event_params)

    if @trackable_event.save
      redirect_to manage_trackable_event_path(@trackable_event), notice: 'Trackable event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /trackable_events/1
  def update
    if @trackable_event.update(trackable_event_params)
      redirect_to manage_trackable_event_path(@trackable_event), notice: 'Trackable event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /trackable_events/1
  def destroy
    @trackable_event.destroy
    redirect_to manage_trackable_events_url, notice: 'Trackable event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trackable_event
      @trackable_event = TrackableEvent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trackable_event_params
      params.require(:trackable_event).permit(:band_id, :trackable_tag_id, :user_id)
    end
end
