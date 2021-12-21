#
# This class represents the interaction with the questionare model, in terms of making any changes to the model.
#
class QuestionnairesController < ApplicationController
  include QuestionnairesControllable

  before_action :logged_in
  before_action :find_questionnaire, only: [:show, :update, :destroy]

  #
  # Calls authenticate_user. Checks if you are logged in and throws autentication error if task fails.
  #
  # @return [<Type>] <description>
  #
  def logged_in
    authenticate_user!
  end

  # GET /questionnaire.json

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def show
  end

  # POST /questionnaire.json

  #
  # Saves/updates user questionare. Checks that the questionare doesn't exist and is being accepted.
  #
  # @return [HTTP Code] 409 if questionnaire already exist; 406 if questionaire is not be accepted.
  #
  def create
    if current_user.reload.questionnaire.present?
      return head :conflict, notice: 'Application already exists.'
    end

    unless HackathonConfig['accepting_questionnaires']
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

  # PUT /questionnaire.json

  #
  # Gets the corresponding id of given schhol name and updates the attribute in user's questianaire.
  #
  # @return [<Type>] <description>
  #
  def update
    update_params = questionnaire_params
    update_params = convert_school_name_to_id(update_params)

    if @questionnaire.update_attributes(update_params)
      head :accepted
    else
      render json: @questionnaire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questionnaire.json

  #
  # Checks if owner of the questionare is a bus captain ,informs all directors that the bus captain left, and deletes.
  #
  # @return [<Type>] <description>
  #
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

  # GET /questionnaire/schools

  #
  # This function provides options of various schools based on the users providing at least 3 characters of their school.
  #
  # @return [<Type>] <description>
  #
  def schools
    if params[:name].blank? || params[:name].length < 3
      head :bad_request
      return
    end
    schools = School.where('name LIKE ?', "%#{params[:name]}%").order(questionnaire_count: :desc).limit(20).select(:name).all
    render json: schools.map(&:name)
  end

  private

  #
  # Identifies the required parameter in each questionarire that need to be filled.
  #
  # @return [<Type>] <description>
  #
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

  #
  # Checks if current users questionare exist.
  #
  # @return [HTTP code] HTTP code 404 Not found.
  #
  def find_questionnaire
    unless current_user.questionnaire.present?
      return head :not_found
    end
    @questionnaire = current_user.questionnaire
  end

  #
  # Checks if the wait list is active, when user submit questionare.
  #
  # @return [String] string of "late_waitlist" if the line "auto_late_waitlist" is set to true
  #
  def default_acc_status
    return "late_waitlist" if HackathonConfig['auto_late_waitlist']
    "pending"
  end
end
