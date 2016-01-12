require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'Validation' do
    let(:blog) { Fabricate :blog }

    it 'is valid' do
      blog.link = 'www.test.com'
      expect(blog.valid?).to be_truthy
    end

    it 'is valid' do
      blog.link = 'http://www.test.com'
      expect(blog.valid?).to be_truthy
    end

    it 'is invalid' do
      blog.link = ''
      expect(blog.valid?).to be_falsey
    end
  end
end
