class QuestionnairesController < ApplicationController
  include QuestionnairesControllable

  before_action :logged_in
  before_action :find_questionnaire, only: [:show, :update, :edit, :destroy]

  def logged_in
    authenticate_user!
  end

  # GET /apply
  # GET /apply.json
  def show
    flash[:alert] = nil
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/new
  # GET /apply/new.json
  def new
    if current_user.questionnaire.present?
      return redirect_to questionnaires_path
    end
    @questionnaire = Questionnaire.new
    @agreements = Agreement.all

    if session["devise.provider_data"] && session["devise.provider_data"]["info"]
      info = session["devise.provider_data"]["info"]
      @skip_my_mlh_fields = true
      if !all_my_mlh_fields_provided?
        flash[:notice] = nil
        flash[:alert] = t(:my_mlh_null, scope: 'errors')
      end
      @questionnaire.tap do |q|
        q.phone          = info["phone_number"]
        q.level_of_study = info["level_of_study"]
        q.major          = info["major"]
        q.date_of_birth  = info["date_of_birth"]
        q.gender         = info["gender"]

        if info["school"]
          school = School.where(name: info["school"]["name"]).first_or_create do |s|
            s.name = info["school"]["name"]
          end
          q.school_id = school.id
        end
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/edit
  def edit
    @agreements = Agreement.all
  end

  # POST /apply
  # POST /apply.json
  def create
    if current_user.reload.questionnaire.present?
      return redirect_to questionnaires_path, notice: 'Application already exists.'
    end
    return unless HackathonConfig['accepting_questionnaires']

    @questionnaire = Questionnaire.new(convert_school_name_to_id(questionnaire_params))
    @questionnaire.user_id = current_user.id
    @agreements = Agreement.all

    respond_to do |format|
      if @questionnaire.save
        @questionnaire.update_attribute(:acc_status, default_acc_status)
        format.html { redirect_to questionnaires_path }
        format.json { render json: @questionnaire, status: :created, location: @questionnaire }
      else
        format.html { render action: "new" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apply
  # PUT /apply.json
  def update
    update_params = questionnaire_params
    update_params = convert_school_name_to_id(update_params)

    respond_to do |format|
      if @questionnaire.update_attributes(update_params)
        format.html { redirect_to questionnaires_path, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_questionnaires_url }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
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
    respond_to do |format|
      format.html { redirect_to questionnaires_url }
      format.json { head :no_content }
    end
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

  def all_my_mlh_fields_provided?
    info = session["devise.provider_data"]["info"]

    return true unless info["phone_number"].blank? || info["level_of_study"].blank? || info["major"].blank? ||
                       info["date_of_birth"].blank? || info["gender"].blank? || info["school"].blank? ||
                       info["school"]["name"].blank?
  end

  def questionnaire_params
    params.require(:questionnaire).permit(
      :email, :experience, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international,
      :portfolio_url, :vcs_url, :bus_captain_interest,
      :phone, :can_share_info, :travel_not_from_school, :travel_location,
      :graduation_year, :race_ethnicity, :resume, :delete_resume, :why_attend, agreement_ids: []
    )
  end

  def find_questionnaire
    unless current_user.questionnaire.present?
      return redirect_to new_questionnaires_path
    end
    @questionnaire = current_user.questionnaire
  end

  def default_acc_status
    return "late_waitlist" if HackathonConfig['auto_late_waitlist']
    "pending"
  end
end
