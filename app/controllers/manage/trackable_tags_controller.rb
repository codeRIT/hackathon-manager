class Manage::TrackableTagsController < Manage::ApplicationController
  before_action :set_trackable_tag, only: [:show, :update, :destroy]

  respond_to :json

  # GET /manage/trackable_tags
  def index
    @trackable_tags = TrackableTag.all.order("name ASC")
  end

  # GET /manage/trackable_tags/1
  def show
  end

  # POST /manage/trackable_tags
  def create
    @trackable_tag = TrackableTag.new(trackable_tag_params)

    if @trackable_tag.save
      head :ok
    else
      render json: @trackable_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /manage/trackable_tags/1
  def update
    if @trackable_tag.update(trackable_tag_params)
      head :ok
    else
      render json: @trackable_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /manage/trackable_tags/1
  def destroy
    @trackable_tag.destroy
    head :ok
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
