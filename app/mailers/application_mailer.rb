class ApplicationMailer < ActionMailer::Base
  default from: Settings.email_sender.user
end
