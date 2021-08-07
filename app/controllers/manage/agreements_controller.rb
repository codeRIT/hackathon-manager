class Manage::AgreementsController < Manage::ApplicationController
  before_action :require_director
  before_action :set_agreement, only: [:show, :update, :destroy]

  respond_to :json

  # GET /agreements
  def index
    @agreements = Agreement.all
  end

  # POST /agreements
  def create
    @agreement = Agreement.new(agreement_params)
    if @agreement.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # PATCH/PUT /agreements/1
  def update
    if @agreement.update_attributes(agreement_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # DELETE /agreements/1
  def destroy
    @agreement.destroy
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def agreement_params
    params.require(:agreement).permit(
      :name, :agreement
    )
  end
end
