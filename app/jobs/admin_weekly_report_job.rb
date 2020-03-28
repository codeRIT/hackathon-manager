class AdminWeeklyReportJob < ApplicationJob
  queue_as :default

  def perform
    # Queue all eligible users and let the is_active (or other) logic determine if they should really receive it
    users = User.where(receive_weekly_report: true)
    users.each do |user|
      AdminMailer.weekly_report(user.id).deliver_later
    end
  end
end
