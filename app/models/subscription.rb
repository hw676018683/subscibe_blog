class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  def unread_count
    blog.articles.count - read_articles.count
  end

  def unread_articles
    blog.articles - read_articles
  end

  def read_blog!
    update read_articles: blog.articles
  end
end