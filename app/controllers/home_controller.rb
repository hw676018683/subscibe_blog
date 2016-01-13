class HomeController < ApplicationController

  def index
    if current_user
      @user_blogs = current_user.user_blogs.includes(:blog)
    end
  end
end
