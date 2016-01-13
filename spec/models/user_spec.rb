require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { Fabricate :user }
  let(:blog) { Fabricate :blog, articles: [{ link: 'test.com', title: 'test' }] }

  describe '#subscibe' do
    it 'creates a new subscription' do
      expect {
        user.subscibe blog
      }.to change { Subscription.count }.by 1
    end

    it 'read_articles equals articles of blog' do
      subscription = user.subscibe blog
      expect(subscription.read_articles).to eq [{"link"=>"test.com", "title"=>"test"}]
    end
  end

  describe '#subscibe?' do
    it 'returns false if not subscibe' do
      expect(user.subscibe?(blog)).to be_falsey
    end

    it 'returns true if subscibe' do
      user.subscibe blog
      expect(user.subscibe?(blog)).to be_truthy
    end
  end
end
