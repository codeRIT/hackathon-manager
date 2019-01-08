class Manage::TrackableTagsController < Manage::ApplicationController
  before_action :set_trackable_tag, only: [:show, :edit, :update, :destroy]

  # GET /trackable_tags
  def index
    @trackable_tags = TrackableTag.all
  end

  # GET /trackable_tags/1
  def show
  end

  # GET /trackable_tags/new
  def new
    @trackable_tag = TrackableTag.new
  end

  # GET /trackable_tags/1/edit
  def edit
  end

  # POST /trackable_tags
  def create
    @trackable_tag = TrackableTag.new(trackable_tag_params)

    if @trackable_tag.save
      redirect_to manage_trackable_tag_path(@trackable_tag), notice: 'Trackable tag was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /trackable_tags/1
  def update
    if @trackable_tag.update(trackable_tag_params)
      redirect_to manage_trackable_tag_path(@trackable_tag), notice: 'Trackable tag was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /trackable_tags/1
  def destroy
    @trackable_tag.destroy
    redirect_to manage_trackable_tags_url, notice: 'Trackable tag was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trackable_tag
      @trackable_tag = TrackableTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trackable_tag_params
      params.require(:trackable_tag).permit(:name)
    end
end
