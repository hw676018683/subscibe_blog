class HomeController < ApplicationController

  def index
    if current_user
      @subscriptions = current_user.subscriptions.includes(:blog)
      @top_10_blogs = Blog.order('subscriptions_count desc').first(10)
    end
  end
end
