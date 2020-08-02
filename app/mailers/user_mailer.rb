class UserMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  add_template_helper(HackathonManagerHelper)

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
    return if @user.blank? || @user.admin? || @user.questionnaire || Time.now.to_date > Date.parse(HackathonConfig["last_day_to_apply"])

    Message.queue_for_trigger("user.24hr_incomplete_application", @user.id)
  end

  def rsvp_reminder_email(user_id)
    @user = User.find_by_id(user_id)
    return if @user.blank? || !@user.questionnaire.acc_status == "accepted" || Time.now.to_date > Date.parse(HackathonConfig["event_start_date"])

    Message.queue_for_trigger("user.rsvp_reminder", @user.id)
  end

  rescue_from SparkPostRails::DeliveryException do |e|
    error_codes_to_not_retry = [
      "1902", # Generation rejection, specific to the Sparkpost API
    ]
    raise e unless e.blank? || error_codes_to_not_retry.include?(e.service_code)
  end
end
