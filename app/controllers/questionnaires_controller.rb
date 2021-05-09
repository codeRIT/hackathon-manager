class QuestionnairesController < ApplicationController
  include QuestionnairesControllable

  before_action :logged_in
  before_action :find_questionnaire, only: [:show, :update, :edit, :destroy]

  def logged_in
    authenticate_user!
  end

  # POST /apply
  # POST /apply.json
  def create
    if current_user.reload.questionnaire.present?
      return head :conflict, notice: 'Application already exists.'
    end
    
    if !HackathonConfig['accepting_questionnaires']
      return head :not_acceptable, notice: 'Not accepting applications.'
    end

    @questionnaire = Questionnaire.new(convert_school_name_to_id(questionnaire_params))
    @questionnaire.user_id = current_user.id

    if @questionnaire.save
      @questionnaire.update_attribute(:acc_status, default_acc_status)
      render json: @questionnaire, status: :created
    else
      render json: @questionnaire.errors, status: :unprocessable_entity
    end
  end

  # PUT /apply
  # PUT /apply.json
  def update
    update_params = questionnaire_params
    update_params = convert_school_name_to_id(update_params)

    if @questionnaire.update_attributes(update_params)
      head :accepted
    else
      render json: @questionnaire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /apply
  # DELETE /apply.json
  def destroy
    if @questionnaire.is_bus_captain
      directors = User.where(role: :director)
      directors.each do |user|
        StaffMailer.bus_captain_left(@questionnaire.bus_list_id, @questionnaire.user_id, user.id).deliver_later
      end
    end

    @questionnaire.destroy
    head :ok
  end

  # GET /apply/schools
  def schools
    if params[:name].blank? || params[:name].length < 3
      head :bad_request
      return
    end
    schools = School.where('name LIKE ?', "%#{params[:name]}%").order(questionnaire_count: :desc).limit(20).select(:name).all
    render json: schools.map(&:name)
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(
      :email, :experience, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international, :country,
      :portfolio_url, :vcs_url, :bus_captain_interest,
      :phone, :can_share_info, :travel_not_from_school, :travel_location,
      :graduation_year, :race_ethnicity, :resume, :delete_resume, :why_attend, agreement_ids: []
    )
  end

  def find_questionnaire
    unless current_user.questionnaire.present?
      return head :not_found
    end
    @questionnaire = current_user.questionnaire
  end

  def default_acc_status
    return "late_waitlist" if HackathonConfig['auto_late_waitlist']
    "pending"
  end
end
