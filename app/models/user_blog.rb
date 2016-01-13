class UserBlog < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  def unread_count
    blog.articles.count - read_articles.count
  end
end
