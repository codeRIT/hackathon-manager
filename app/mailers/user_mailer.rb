class UserMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  helper HackathonManagerHelper

  def bulk_message_email(message_id, user_id, message = nil, use_examples = false)
    @message = message || Message.find_by_id(message_id)
    @user = User.find_by_id(user_id)
    @use_examples = use_examples
    return if @user.blank? || @message.blank?

    mail(
      to: pretty_email(@user.full_name, @user.email),
      subject: @message.subject,
    )
  end

  def incomplete_reminder_email(user_id)
    @user = User.find_by_id(user_id)
    return if @user.blank? || @user.director? || @user.questionnaire || Time.now.in_time_zone.to_date > Date.parse(HackathonConfig["last_day_to_apply"]).in_time_zone.to_date

    Message.queue_for_trigger("user.24hr_incomplete_application", @user.id)
  end

  def rsvp_reminder_email(user_id)
    @user = User.find_by_id(user_id)
    return if @user.blank? || @user.questionnaire.blank? || @user.questionnaire.acc_status != "accepted" || Time.now.in_time_zone.to_date > Date.parse(HackathonConfig["event_start_date"]).in_time_zone.to_date
    Message.queue_for_trigger("questionnaire.rsvp_reminder", @user.id)
  end
end
