class AdminMailer < ApplicationMailer
  include Roadie::Rails::Automatic
  add_template_helper(HackathonManagerHelper)

  layout "admin_mailer"

  def weekly_report(user_id)
    # Don't send emails more than 7 days after event starts
    stop_date = Date.parse(HackathonConfig["event_start_date"]) + 7.days
    return if Date.today > stop_date

    @user = User.find_by_id(user_id)

    return unless @user.safe_receive_weekly_report

    @period_start = 7.days.ago.at_beginning_of_day
    @period_end = 1.day.ago.at_end_of_day
    @period = @period_start..@period_end

    @applications = report_metric(Questionnaire, :created_at)
    @rsvp_confirmed = report_metric(Questionnaire.where(acc_status: "rsvp_confirmed"), :acc_status_date)
    @rsvp_denied = report_metric(Questionnaire.where(acc_status: "rsvp_denied"), :acc_status_date)

    @bus_metrics = BusList.all.map do |bus_list|
      {
        name: bus_list.name,
        total: bus_list.passengers.count,
      }
    end

    @messages_sent = Message.bulk.where(delivered_at: @period).count

    @new_admissions_metrics = [@applications, @rsvp_confirmed, @rsvp_denied].any? { |x| x[:new].positive? }
    @new_communication_metrics = @messages_sent.positive?

    # Don't send email if no new activity
    return if !@new_admissions_metrics && !@new_bus_list_metrics && !@new_communication_metrics

    mail(
      to: pretty_email(@user.full_name, @user.email),
      subject: "Your Weekly Report",
    )
  end

  private

  def report_metric(query_base, new_query_field)
    {
      new: query_base.where(new_query_field => @period).count,
      total: query_base.count,
    }
  end
end
