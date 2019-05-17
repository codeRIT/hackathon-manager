if defined?(ActionMailer::Preview)
  class MailPreview < ActionMailer::Preview
    def bulk_message_email
      message = Message.first
      Mailer.bulk_message_email(message, User.first.id)
    end
  end
end
