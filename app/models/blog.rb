class Blog < ActiveRecord::Base
  has_many :subscriptions
  has_many :feedbacks

  before_validation :format_link

  validates :link, presence: true, uniqueness: true, format: { with: URI.regexp(%w(http https)) }

  after_update :notify_subscribers, if: :articles_changed?

  def self.format_link link
    link = link.to_s
    unless link.start_with?('http') || link.start_with?('https')
      link = "http://#{link}"
    end

    unless link.end_with?('/')
      link = "#{link}/"
    end
    link
  end

  def error?
    articles.empty? && last_crawl_at && last_crawl_at > updated_at
  end

  private

  def format_link
    return if link.blank?

    self.link = self.class.format_link(link)
  end

  def notify_subscribers
    subscriptions.each do |subscription|
      if subscription.read_articles.empty?
        subscription.read_blog!
      else
        NotificationMailer.notice_update(subscription).deliver_now if subscription.user.email_notify
      end
    end
  end
end
