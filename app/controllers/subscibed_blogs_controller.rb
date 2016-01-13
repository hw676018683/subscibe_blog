class SubscibedBlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_subscibed_blog

  def show
    @unread_articles = @subscibed_blog.unread_articles
    @subscibed_blog.read_blog!
  end

  private

  def find_subscibed_blog
    @subscibed_blog = current_user.user_blogs.find params[:id]
  end
end