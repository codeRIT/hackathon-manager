class Manage::TrackableTagsController < Manage::ApplicationController
  before_action :set_trackable_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /manage/trackable_tags
  def index
    @trackable_tags = TrackableTag.all.order("name ASC")
    respond_with(:manage, @trackable_tags)
  end

  # GET /manage/trackable_tags/1
  def show
    respond_with(:manage, @trackable_tag)
  end

  # GET /manage/trackable_tags/new
  def new
    @trackable_tag = TrackableTag.new
    respond_with(:manage, @questionnaire)
  end

  # GET /manage/trackable_tags/1/edit
  def edit
  end

  # POST /manage/trackable_tags
  def create
    @trackable_tag = TrackableTag.new(trackable_tag_params)

    if @trackable_tag.save
      flash[:notice] = 'Trackable tag was successfully created.'
      respond_with(:manage, @trackable_tag)
    else
      response_view_or_errors :new, @trackable_tag
    end
  end

  # PATCH/PUT /manage/trackable_tags/1
  def update
    if @trackable_tag.update(trackable_tag_params)
      flash[:notice] = 'Trackable tag was successfully updated.'
      respond_with(:manage, @trackable_tag)
    else
      response_view_or_errors :edit, @trackable_tag
    end
  end

  # DELETE /manage/trackable_tags/1
  def destroy
    @trackable_tag.destroy
    flash[:notice] = 'Trackable tag was successfully destroyed.'
    respond_with(:manage, @trackable_tag)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trackable_tag
    @trackable_tag = TrackableTag.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def trackable_tag_params
    params.require(:trackable_tag).permit(:name, :allow_duplicate_band_events)
  end
end
