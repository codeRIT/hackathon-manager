class Manage::QuestionnairesController < Manage::ApplicationController
  include QuestionnairesControllable

  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy, :check_in, :update_acc_status]

  respond_to :html, :json

  def index
    respond_with(:manage, Questionnaire.all)
  end

  def datatable
    render json: QuestionnaireDatatable.new(params, view_context: view_context)
  end

  def show
    @agreements = Agreement.all
    respond_with(:manage, @questionnaire)
  end

  def new
    @questionnaire = ::Questionnaire.new
    respond_with(:manage, @questionnaire)
  end

  def edit
  end

  def create
    create_params = questionnaire_params
    email = create_params.delete(:email)
    create_params = convert_school_name_to_id(create_params)
    create_params = convert_boarded_bus_param(create_params)
    @questionnaire = ::Questionnaire.new(create_params)
    users = User.where(email: email)
    user = users.count == 1 ? users.first : User.new(email: email, password: Devise.friendly_token.first(10))
    @questionnaire.user = user
    if @questionnaire.valid?
      if user.save
        @questionnaire.save
      else
        flash[:alert] = user.errors.full_messages.join(", ")
        if user.errors.include?(:email)
          @questionnaire.errors.add(:email, user.errors[:email].join(", "))
        end
        return render "new"
      end
    end
    respond_with(:manage, @questionnaire)
  end

  def update
    update_params = questionnaire_params
    email = update_params.delete(:email)
    # Take our nested user object out as a whole
    user_params = params[:questionnaire][:user]
    if user_params
      @questionnaire.user.update_attributes(first_name: user_params[:first_name])
      @questionnaire.user.update_attributes(last_name: user_params[:last_name])
    end
    @questionnaire.user.update_attributes(email: email) if email.present?
    update_params = convert_school_name_to_id(update_params)
    update_params = convert_boarded_bus_param(update_params, @questionnaire)
    if update_params[:validate_switch] == 'false'
      @questionnaire.update_with_invalid_attributes(update_params)
    else
      @questionnaire.update_attributes(update_params)
    end
    respond_with(:manage, @questionnaire)
  end

  def check_in
    respond_to do |format|
      format.json do
        if params[:check_in] == "true"
          check_in_attendee
        elsif params[:check_in] == "false"
          check_out_attendee
        end
      end
      format.html do
        redirect_to_checkins = params[:redirect_to_checkins] || false
        show_redirect_path = redirect_to_checkins ? manage_checkin_path(@questionnaire) : manage_questionnaire_path(@questionnaire)
        index_redirect_path = redirect_to_checkins ? manage_checkins_path : manage_questionnaires_path
        if params[:check_in] == "true"
          if params[:questionnaire]
            q_params = params.require(:questionnaire).permit(:phone, :can_share_info, :email)
            email = q_params.delete(:email)
            @questionnaire.update_attributes(q_params)
            @questionnaire.user.update_attributes(email: email)
          end
          unless @questionnaire.valid?
            flash[:alert] = @questionnaire.errors.full_messages.join(", ")
            redirect_to show_redirect_path
            return
          end
          check_in_attendee
          flash[:notice] = t(:checked_in, scope: 'messages', user_full_name: @questionnaire.user.full_name)
        elsif params[:check_in] == "false"
          check_out_attendee
          flash[:notice] = t(:checked_out, scope: 'messages', user_full_name: @questionnaire.user.full_name)
        else
          flash[:alert] = t(:missing_check_in, scope: 'messages')
          redirect_to show_redirect_path
          return
        end
        redirect_to index_redirect_path
      end
    end
  end

  def destroy
    if @questionnaire.is_bus_captain
      directors = User.where(role: :director)
      directors.each do |user|
        StaffMailer.bus_captain_left(@questionnaire.bus_list_id, @questionnaire.user_id, user.id).deliver_later
      end
    end

    @questionnaire.destroy
    respond_with(:manage, @questionnaire)
  end

  def update_acc_status
    new_status = params[:questionnaire][:acc_status]
    if new_status.blank?
      flash[:alert] = "No status provided"
      redirect_to(manage_questionnaire_path(@questionnaire))
      return
    end

    @questionnaire.acc_status = new_status
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now

    if @questionnaire.save(validate: false)
      flash[:notice] = "Updated acceptance status to \"#{Questionnaire::POSSIBLE_ACC_STATUS[new_status]}\""
    else
      flash[:alert] = "Failed to update acceptance status"
    end

    redirect_to manage_questionnaire_path(@questionnaire)
  end

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

  def check_in_attendee
    @questionnaire.update_attribute(:checked_in_at, Time.now)
    @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
  end

  def check_out_attendee
    @questionnaire.update_attribute(:checked_in_at, nil)
    @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
  end

  def questionnaire_params
    # Note that this ONLY considers parameters for the questionnaire, not the user.
    # TODO: Refactor "email" out to user as first_name and last_name were
    params.require(:questionnaire).permit(
      :email, :experience, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international,
      :portfolio_url, :vcs_url, :bus_captain_interest, :phone, :can_share_info,
      :travel_not_from_school, :travel_location,
      :graduation_year, :race_ethnicity, :resume, :delete_resume, :why_attend,
      :bus_list_id, :is_bus_captain, :boarded_bus, :country, :validate_switch
    )
  end

  def convert_boarded_bus_param(values, questionnaire = nil)
    boarded_bus = values.delete(:boarded_bus)
    current_value = questionnaire&.boarded_bus_at
    values[:boarded_bus_at] = boarded_bus == "1" ? (current_value || Time.now) : nil
    values
  end

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end
end
