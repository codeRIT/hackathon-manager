class RsvpsController < ApplicationController
  before_action :logged_in
  before_action :check_user_has_questionnaire
  before_action :find_questionnaire
  before_action :require_accepted_questionnaire

  def logged_in
    authenticate_user!
  end

  # PATCH /rsvp/accept
  def accept
    @questionnaire.acc_status = "rsvp_confirmed"
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    if @questionnaire.save
      head :ok
    else
      head :not_acceptable
    end
  end

  # PATCH /rsvp/deny
  def deny
    @questionnaire.acc_status = "rsvp_denied"
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    if @questionnaire.save
      head :ok
    else
      head :not_acceptable
    end
  end

  private

  def find_questionnaire
    @questionnaire = current_user.questionnaire
  end

  def check_user_has_questionnaire
    head :forbidden if current_user.questionnaire.nil?
  end

  def require_accepted_questionnaire
    return if @questionnaire.can_rsvp? || @questionnaire.checked_in?

    head :forbidden
  end
end
