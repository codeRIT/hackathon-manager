class Manage::AgreementsController < Manage::ApplicationController
  before_action :require_director
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /agreements
  def index
    @agreements = Agreement.all
  end

  # GET /agreements/new
  def new
    @agreement = Agreement.new
  end

  # GET /agreements/1/edit
  def edit
  end

  # POST /agreements
  def create
    if !agreement_params['agreement_url'].start_with?('http://', 'https://')
      flash[:alert] = "Agreement URL must start with http:// or https://"
      redirect_to new_manage_agreement_path
    else
      @agreement = Agreement.new(agreement_params)
      @agreement.save
      flash[:notice] = "#{@agreement.name} was successfully created."
      redirect_to manage_agreements_path
    end
  end

  # PATCH/PUT /agreements/1
  def update
    if !agreement_params['agreement_url'].nil? && !agreement_params['agreement_url'].start_with?('http://', 'https://')
      flash[:alert] = "Agreement URL must start with http:// or https://"
      redirect_to edit_manage_agreement_url
    else
      @agreement.update_attributes(agreement_params)
      flash[:notice] = nil
      redirect_to manage_agreements_path
    end
  end

  # DELETE /agreements/1
  def destroy
    @agreement.destroy
    flash[:notice] = 'Agreement was successfully destroyed.'
    respond_with(:manage, @agreement, location: manage_agreements_path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_agreement
    @agreement = Agreement.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def agreement_params
    params.require(:agreement).permit(
      :name, :agreement_url
    )
  end
end
