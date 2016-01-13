class HomeController < ApplicationController

  def index
    if current_user
      @subscriptions = current_user.subscriptions.includes(:blog)
    end
  end
end
