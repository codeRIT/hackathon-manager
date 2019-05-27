if defined?(ActionMailer::Preview)
  class MailPreview < ActionMailer::Preview
    def bulk_message_email
      message = Message.first
      UserMailer.bulk_message_email(message, User.first.id)
    end

    def admin_weekly_report
      AdminMailer.weekly_report(User.first.id)
    end
  end
end
