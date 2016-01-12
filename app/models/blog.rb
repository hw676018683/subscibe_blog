class Blog < ActiveRecord::Base
  has_many :user_blogs

  before_validation :format_link

  validates :link, presence: true, uniqueness: true, format: { with: URI.regexp(%w(http https)) }

  private

  def format_link
    return if link.blank?

    unless link.start_with?('http') || link.start_with?('https')
      self.link = "http://#{link}"
    end

    unless link.end_with?('/')
      self.link = "#{link}/"
    end
  end
end
