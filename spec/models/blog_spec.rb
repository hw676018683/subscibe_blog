require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) { Fabricate :blog }

  describe 'Validation' do
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

  describe 'update' do
    let(:user) { Fabricate :user }
    before do
      user.subscibe blog
    end

    it 'sends a email for subscriber if email_notify is true' do
      expect {
        blog.update articles: [{ link: 'http://test.com/xx', title: 'xx' }]
      }.to change { ActionMailer::Base.deliveries.size }.by 1
    end

    it 'doesnt send a email for subscriber if email_notify is false' do
      user.update email_notify: false
      expect {
        blog.update articles: [{ link: 'http://test.com/xx', title: 'xx' }]
      }.not_to change { ActionMailer::Base.deliveries.size }
    end
  end
end
