class Manage::DataExportsController < Manage::ApplicationController
  before_action :require_director

  before_action :set_data_export, only: [:destroy]

  respond_to :json

  # GET /manage/data_exports
  def index
    @data_exports = DataExport.all.order(created_at: :desc)
    @params = {}
    if params[:export_type]
      @params = params.require(:data_export).permit(:export_type).reject { |_, v| v.blank? }
      @data_exports = @data_exports.where(@params)
    end
  end

  # POST /manage/data_exports
  def create
    @data_export = DataExport.new(data_export_params)

    if @data_export.save
      @data_export.reload.enqueue!
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /manage/data_exports/1
  def destroy
    if @data_export.destroy
      head :ok
    else
      head :unprocessable_entity
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
