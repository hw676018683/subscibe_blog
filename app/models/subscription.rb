class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog

  before_validation :format_blog_link

  validates :blog_name, presence: true
  validates :blog_link, presence: true, uniqueness: { scope: [:user_id] }, format: { with: URI.regexp(%w(http https)) }

  after_save :set_blog, if: :blog_link_changed?

  def unread_count
    blog.articles.count - read_articles.count
  end

  def unread_articles
    blog.articles - read_articles
  end

  def read_blog!
    update read_articles: blog.articles
  end

  private

  def set_blog
    blog = Blog.where(link: blog_link).first_or_create
    update_columns blog_id: blog.id, read_articles: blog.articles
  end

  def format_blog_link
    self.blog_link = Blog.format_link(blog_link)
  end
end