class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :subscibe_blogs, through: :subscriptions, source: :blog

  def subscibe blog
    subscriptions.create blog: blog, read_articles: blog.articles
  end

  def subscibe? blog
    subscriptions.exists?(blog: blog)
  end
end
