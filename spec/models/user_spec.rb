require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { Fabricate :user }
  let(:blog) { Fabricate :blog, articles: [{ link: 'test.com', title: 'test' }] }

end
