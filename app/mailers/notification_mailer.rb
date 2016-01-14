class NotificationMailer < ApplicationMailer

  def notice_update subscription
    @subscription = subscription
    mail to: @subscription.user.email, subject: '博客跟新通知'
  end
end
