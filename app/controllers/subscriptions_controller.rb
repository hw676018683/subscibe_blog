class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subscription, only: [:show]

  def show
    @unread_articles = @subscription.unread_articles
    @subscription.read_blog!
  end

  def new
    @subscription = current_user.subscriptions.new
  end

  private

  def find_subscription
    @subscription = current_user.subscriptions.find params[:id]
  end
end