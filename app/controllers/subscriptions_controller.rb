class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subscription, only: [:show, :destroy]

  def show
    @unread_articles = @subscription.unread_articles
    @subscription.read_blog!
  end

  def new
    @subscription = current_user.subscriptions.new
  end

  def create
    blog = Blog.where(link: Blog.format_link(params[:link])).first_or_create

    if current_user.subscibe? blog
      flash[:danger] = "你已经订阅了 #{params[:link]}"
      redirect_to root_path
    else
      subscription = current_user.subscibe blog
      redirect_to subscription, flash: { success: '订阅成功' }
    end
  end

  def destroy
    @subscription.destroy
    redirect_to root_path, flash: { success: '取消订阅成功' }
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find params[:id]
  end
end