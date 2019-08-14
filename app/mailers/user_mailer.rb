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
    @questionnaire = Questionnaire.where(user_id: user_id)
    more_than_two_weeks = ((@questionnaire.acc_status_date - Date.parse(HackathonConfig["last_day_to_apply"])).to_i > 14) && (@questionnaire.acc_status_date + 7 == Date.today)
    more_than_ten_days = ((@questionnaire.acc_status_date - Date.parse(HackathonConfig["last_day_to_apply"])).to_i > 10) && (Date.parse(HackathonConfig["last_day_to_apply"]) - 5 == Date.today)
    more_than_three_days = ((@questionnaire.acc_status_date - Date.parse(HackathonConfig["last_day_to_apply"])).to_i > 3) && (Date.parse(HackathonConfig["last_day_to_apply"]) - 2 == Date.today)
    if @questionnaire.acc_status == "accepted"
      if more_than_two_weeks || more_than_ten_days || more_than_three_days
        Message.queue_for_trigger("user.rsvp_reminder_email", user_id)
      end
    end
  end

  rescue_from SparkPostRails::DeliveryException do |e|
    error_codes_to_not_retry = [
      "1902", # Generation rejection, specific to the Sparkpost API
    ]
    raise e unless e.blank? || error_codes_to_not_retry.include?(e.service_code)
  end
end
