class Manage::AgreementsController < Manage::ApplicationController
  before_action :require_director
  before_action :set_agreement, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /agreements
  def index
    @agreements_search = Agreement.ransack(params[:agreements_search], search_key: :agreements_search)
    @agreements = @agreements_search.result(distinct: true)
    @agreements_pagy, @agreements = pagy(@agreements, page_param: 'agreements_page', items: 10)
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
    @agreement = Agreement.new(agreement_params)
    @agreement.save
    flash[:notice] = "#{@agreement.name} was successfully created."
    redirect_to manage_agreements_path
  end

  # PATCH/PUT /agreements/1
  def update
    @agreement.update(agreement_params)
    flash[:notice] = nil
    redirect_to manage_agreements_path
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
      :name, :agreement
    )
  end
end
