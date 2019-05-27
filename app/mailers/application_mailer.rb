class ApplicationMailer < ActionMailer::Base
  default from: -> { HackathonConfig["email_from"] }
  layout "mailer"

  def pretty_email(name, email)
    return email if name.blank?

    "\"#{name}\" <#{email}>"
  end
end
