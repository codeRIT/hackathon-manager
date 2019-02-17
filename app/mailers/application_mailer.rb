class ApplicationMailer < ActionMailer::Base
  default from: HackathonConfig['email_from']
  layout 'mailer'
end
