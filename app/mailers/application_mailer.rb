class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.hackathon['email_from']
  layout 'mailer'
end
