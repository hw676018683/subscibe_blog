class NotificationMailer < ApplicationMailer

  def update_notice user, subscription
    @user = user
    @subscription = subscription
    mail to: @user.email, subject: '博客跟新通知'
  end
end
