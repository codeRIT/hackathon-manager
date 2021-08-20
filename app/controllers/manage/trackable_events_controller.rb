class Manage::TrackableEventsController < Manage::ApplicationController
  before_action :set_trackable_event, only: [:show, :update, :destroy]
  before_action :scope_organizer_access, only: [:update, :destroy]

  respond_to :json

  # GET /manage/trackable_events
  def index
    @trackable_events = TrackableEvent.all
    @params = {}
    if params[:trackable_event]
      @params = params.require(:trackable_event).permit(:user_id, :band_id, :trackable_tag_id).reject { |_, v| v.blank? }
      @trackable_events = @trackable_events.where(@params)
    end
  end

  # GET /manage/trackable_events/1
  def show
  end

  # GET /manage/trackable_events/new
  def new
    trackable_tag_id = params[:trackable_tag_id]
    @trackable_event = TrackableEvent.new(trackable_tag_id: trackable_tag_id)
  end

  # GET /manage/trackable_events/1/edit
  def edit
  end

  # POST /manage/trackable_events
  def create
    @trackable_event = TrackableEvent.new(trackable_event_params.merge(user_id: current_user.id))

    if @trackable_event.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # PATCH/PUT /manage/trackable_events/1
  def update
    if @trackable_event.update(trackable_event_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /manage/trackable_events/1
  def destroy
    @trackable_event.destroy
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trackable_event
    @trackable_event = TrackableEvent.find_by(id: params[:id])
    head :not_found unless @trackable_event.present?
  end

  # Only allow a trusted parameter "white list" through.
  def trackable_event_params
    params.require(:trackable_event).permit(:band_id, :trackable_tag_id)
  end

  # Permit limited-access directors (overrides Manage::ApplicationController#limit_write_access_to_directors)
  def limit_write_access_to_directors
  end

  # If the user isn't a director, scope changes only to those they created
  def scope_organizer_access
    return if current_user.director? || @trackable_event.blank? || @trackable_event.user.blank?

    head :unauthorized if @trackable_event.user != current_user
  end
end
