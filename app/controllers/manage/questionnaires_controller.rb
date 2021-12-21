#
# This class represents the management of the questionaire model.
#
class Manage::QuestionnairesController < Manage::ApplicationController
  include QuestionnairesControllable

  before_action :set_questionnaire, only: [:show, :update, :destroy, :check_in, :update_acc_status]

  respond_to :json

  #
  # Gets all the questionaire currently available.
  #
  # @return [<Type>] <description>
  #
  def index
    @questionnaires = Questionnaire.all
  end

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def show
  end

  #
  # Updates the parameters in the questionaire and checks if the prameters were successfully change.
  #
  # @return [<Type>] <description>
  #
  def update
    update_params = questionnaire_params
    update_params = convert_school_name_to_id(update_params)
    update_params = convert_boarded_bus_param(update_params, @questionnaire)
    if @questionnaire.update_attributes(update_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  #
  # Updates the time and user id of the questionare submitted if check in is true else throws HTTP error.
  #
  # @return [<Type>] <description>
  #
  def check_in
    if params[:check_in] == "true"
      if @questionnaire.update_attributes(checked_in_at: Time.now, checked_in_by_id: current_user.id)
        head :ok
      else
        head :unprocessable_entity
      end
    else
      if @questionnaire.update_attributes(checked_in_at: 'nil', checked_in_by_id: current_user.id)
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end

  #
  # Checks if questionnaire is a bus captain and notifies staff that bus captian left, then deletes questionnaire.
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

    if @questionnaire.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  #
  # Updates the status of questionnare, if no status is present an error is thrown.
  #
  # @return [<Type>] <description>
  #
  def update_acc_status
    new_status = params[:questionnaire][:acc_status]
    if new_status.blank?
      render json: ErrorResponse.new(:questionnaire_updateAccStatus_blankStatus), status: :unprocessable_entity
      return
    end

    @questionnaire.acc_status = new_status
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now

    if @questionnaire.save(validate: false)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  #
  # Gets both list of action and ids.
  #
  # @return [<Type>] <description>
  #
  def bulk_apply
    action = params[:bulk_action]
    ids = params[:bulk_ids]
    if action.blank? || ids.blank?
      head :bad_request
      return
    end
    Questionnaire.find(ids).each do |q|
      q.acc_status = action
      q.acc_status_author_id = current_user.id
      q.acc_status_date = Time.now
      q.save(validate: false)
    end
    head :ok
  end

  private


  #
  # Checks if all the reqired params in a questionnaire are filled.
  #
  # @return [<Type>] <description>
  #
  def questionnaire_params
    # Note that this ONLY considers parameters for the questionnaire, not the user.
    params.require(:questionnaire).permit(
      :experience, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international,
      :portfolio_url, :vcs_url, :bus_captain_interest, :phone, :can_share_info,
      :travel_not_from_school, :travel_location,
      :graduation_year, :race_ethnicity, :resume, :delete_resume, :why_attend,
      :bus_list_id, :is_bus_captain, :boarded_bus
    )
  end

  #
  # Deletes boarded_bus param in questionnaire and updates the time when the bus was boarded.
  #
  # @param [<Type>] values list of parameter values from the user questinnaire.
  # @param [<Type>] questionnaire User questionnaire.
  #
  # @return [<Type>] list of updated values in user questionnaire.
  #
  def convert_boarded_bus_param(values, questionnaire = nil)
    boarded_bus = values.delete(:boarded_bus)
    current_value = questionnaire&.boarded_bus_at
    values[:boarded_bus_at] = boarded_bus == "1" ? (current_value || Time.now) : nil
    values
  end

  #
  # Takes user parameter values and inserts them into a questionnaire.
  #
  # @return [<Type>] <description>
  #
  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end
end
