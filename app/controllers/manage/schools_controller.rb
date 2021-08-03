class Manage::SchoolsController < Manage::ApplicationController
  before_action :find_school, only: [:show, :update, :destroy, :perform_merge]

  respond_to :json

  def index
    @schools = School.all
  end

  def show
  end

  def create
    @school = ::School.new(school_params)
    if @school.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def update
    if @school.update_attributes(school_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @school.destroy
    head :ok
  end

  def perform_merge
    new_school_name = params[:school][:id]
    if new_school_name.blank?
      head :bad_request
      return
    end

    new_school = School.where(name: new_school_name).first
    if new_school.blank?
      head :bad_request
      return
    end

    old_school = @school.clone
    @school.destroy
    Questionnaire.where(school_id: old_school.id).each do |q|
      q.update_attribute(:school_id, new_school.id)
    end

    SchoolNameDuplicate.create(name: old_school.name, school_id: new_school.id)

    head :ok
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
