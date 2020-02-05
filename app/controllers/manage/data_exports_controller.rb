class Manage::DataExportsController < Manage::ApplicationController
  skip_before_action :require_admin_or_limited_admin
  before_action :require_full_admin

  before_action :set_data_export, only: [:destroy]

  respond_to :html, :json

  # GET /manage/data_exports
  def index
    @data_exports = DataExport.all.order(created_at: :desc)
    @params = {}
    if params[:export_type]
      @params = params.require(:data_export).permit(:export_type).reject { |_, v| v.blank? }
      @data_exports = @data_exports.where(@params)
    end
    respond_with(:manage, @data_exports)
  end

  # GET /manage/data_exports/new
  def new
    export_type = params[:export_type]
    @data_export = DataExport.new(export_type: export_type)
    respond_with(:manage, @data_export)
  end

  # POST /manage/data_exports
  def create
    @data_export = DataExport.new(data_export_params)

    if @data_export.save
      @data_export.enqueue!
      respond_to do |format|
        format.html { redirect_to manage_data_exports_path, notice: "Data export was successfully created." }
        format.json { render json: @data_export }
      end
    else
      response_view_or_errors :new, @data_export
    end
  end

  # DELETE /manage/data_exports/1
  def destroy
    @data_export.destroy
    respond_to do |format|
      format.html { redirect_to manage_data_exports_path, notice: "Data export was successfully destroyed." }
      format.json { render json: @data_export }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_data_export
    @data_export = DataExport.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def data_export_params
    params.require(:data_export).permit(:export_type)
  end
end
