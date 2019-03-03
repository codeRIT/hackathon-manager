class Manage::QuestionnairesController < Manage::ApplicationController
  include QuestionnairesControllable

  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy, :check_in, :convert_to_admin, :update_acc_status, :message_events]

  respond_to :html, :json

  def index
    respond_with(:manage, Questionnaire.all)
  end

  def datatable
    render json: QuestionnaireDatatable.new(view_context)
  end

  def show
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
        flash[:notice] = user.errors.full_messages.join(", ")
        if user.errors.include?(:email)
          @questionnaire.errors.add(:email, user.errors[:email].join(", "))
        end
        return render 'new'
      end
    end
    respond_with(:manage, @questionnaire)
  end

  def update
    update_params = questionnaire_params
    email = update_params.delete(:email)
    @questionnaire.user.update_attributes(email: email) if email.present?
    update_params = convert_school_name_to_id(update_params)
    update_params = convert_boarded_bus_param(update_params, @questionnaire)
    @questionnaire.update_attributes(update_params)
    respond_with(:manage, @questionnaire)
  end

  def check_in
    redirect_to_checkins = params[:redirect_to_checkins] || false
    show_redirect_path = redirect_to_checkins ? manage_checkin_path(@questionnaire) : manage_questionnaire_path(@questionnaire)
    index_redirect_path = redirect_to_checkins ? manage_checkins_path : manage_questionnaires_path
    if params[:check_in] == "true"
      if params[:questionnaire]
        q_params = params.require(:questionnaire).permit(:agreement_accepted, :phone, :can_share_info, :email)
        email = q_params.delete(:email)
        @questionnaire.update_attributes(q_params)
        @questionnaire.user.update_attributes(email: email)
      end
      unless @questionnaire.valid?
        flash[:notice] = @questionnaire.errors.full_messages.join(", ")
        redirect_to show_redirect_path
        return
      end
      @questionnaire.update_attribute(:checked_in_at, Time.now)
      @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
      flash[:notice] = "Checked in #{@questionnaire.full_name}."
    elsif params[:check_in] == "false"
      @questionnaire.update_attribute(:checked_in_at, nil)
      @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
      flash[:notice] = "#{@questionnaire.full_name} no longer checked in."
    else
      flash[:notice] = "No check-in action provided!"
      redirect_to show_redirect_path
      return
    end
    redirect_to index_redirect_path
  end

  def convert_to_admin
    user = @questionnaire.user
    @questionnaire.destroy
    user.update_attributes(role: :admin)
    redirect_to edit_manage_admin_path(user)
  end

  def destroy
    user = @questionnaire.user
    @questionnaire.destroy
    user.destroy if user.present?
    respond_with(:manage, @questionnaire)
  end

  def update_acc_status
    new_status = params[:questionnaire][:acc_status]
    if new_status.blank?
      flash[:notice] = "No status provided"
      redirect_to(manage_questionnaire_path(@questionnaire))
      return
    end

    @questionnaire.acc_status = new_status
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now

    if @questionnaire.save(validate: false)
      flash[:notice] = "Updated acceptance status to \"#{Questionnaire::POSSIBLE_ACC_STATUS[new_status]}\""
    else
      flash[:notice] = "Failed to update acceptance status"
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

  def message_events
    render json: @questionnaire.message_events
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(
      :email, :experience, :first_name, :last_name, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international,
      :portfolio_url, :vcs_url, :agreement_accepted, :bus_captain_interest,
      :phone, :can_share_info, :code_of_conduct_accepted,
      :travel_not_from_school, :travel_location, :data_sharing_accepted,
      :graduation_year, :race_ethnicity, :resume, :delete_resume, :why_attend,
      :bus_list_id, :is_bus_captain, :boarded_bus
    )
  end

  def convert_boarded_bus_param(values, questionnaire = nil)
    boarded_bus = values.delete(:boarded_bus)
    current_value = questionnaire&.boarded_bus_at
    values[:boarded_bus_at] = boarded_bus == '1' ? (current_value || Time.now) : nil
    values
  end

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end
end
