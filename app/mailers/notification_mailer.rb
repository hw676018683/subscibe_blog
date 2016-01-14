class NotificationMailer < ApplicationMailer

  def notice_update subscription
    @subscription = subscription
    mail to: @subscription.user.email, subject: '博客更新通知'
    subscription.read_blog!
  end
end
