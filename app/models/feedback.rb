class Feedback < ActiveRecord::Base
  belongs_to :blog

  validates :content, presence: true
end
