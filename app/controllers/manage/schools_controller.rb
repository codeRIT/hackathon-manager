class Manage::SchoolsController < Manage::ApplicationController
  before_action :limit_write_access_to_directors, only: ["edit", "update", "new", "create", "destroy", "merge", "perform_merge"]
  before_action :find_school, only: [:show, :edit, :update, :destroy, :merge, :perform_merge]

  respond_to :html, :json

  def index
    @schools_search = School.ransack(params[:schools_search], search_key: :schools_search)
    @schools = @schools_search.result(distinct: true)
    @schools_pagy, @schools = pagy(@schools, page_param: 'schools_page', items: 10)
  end

  def show
    @questionnaires_search = Questionnaire.ransack(params[:questionnaires_search], search_key: :questionnaires_search)
    @questionnaires = @questionnaires_search.result.includes(:user, :school, :bus_list).where(school_id: @school.id)
    @questionnaires_pagy, @questionnaires = pagy(@questionnaires, page_param: 'questionnaire_page', items: 10)
    respond_with(:manage, @school)
  end

  def new
    @school = ::School.new
    respond_with(:manage, @school)
  end

  def edit
  end

  def create
    @school = ::School.new(school_params)
    @school.save
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def update
    @school.update(school_params)
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def destroy
    @school.destroy
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def merge
  end

  def perform_merge
    new_school_name = params[:school][:id]
    if new_school_name.blank?
      flash[:alert] = "Error: Must include the new school to merge into!"
      render :merge
      return
    end

    new_school = School.where(name: new_school_name).first
    if new_school.blank?
      flash[:alert] = "Error: School doesn't exist: #{new_school_name}"
      render :merge
      return
    end

    Questionnaire.where(school_id: @school.id).each do |q|
      q.update_attribute(:school_id, new_school.id)
    end

    SchoolNameDuplicate.create(name: @school.name, school_id: new_school.id)

    @school.reload

    if @school.questionnaire_count < 1
      @school.destroy
    else
      flash[:alert] = "*** Old school NOT deleted: #{@school.questionnaire_count} questionnaires still associated!\n"
    end

    redirect_to manage_school_path(new_school)
  end

  private

  def school_params
    params.require(:school).permit(
      :name, :address, :city, :state, :is_home
    )
  end

  def find_school
    @school = ::School.find(params[:id])
  end
end
