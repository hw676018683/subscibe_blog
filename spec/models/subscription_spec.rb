require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { Fabricate :user }
  let!(:subscription) { Fabricate :subscription, user: user, blog_link: 'http://test.com' }
  let!(:blog) { Fabricate :blog, link: 'test1.com', articles: [{ link: 'test1.com/xx', title: 'xx' }] }

  describe 'update' do

    context 'blog_link changes' do
      it 'creates a new blog if the blog not exists' do
        expect {
          subscription.update blog_link: 'new.com'
        }.to change { Blog.count }.by 1
      end

      it 'updates the blog_id' do
        subscription.update blog_link: 'test1.com'
        expect(subscription.reload.blog_id).to eq blog.id
      end

      it 'updates the read_articles' do
        subscription.update blog_link: 'test1.com'
        expect(subscription.reload.read_articles).to eq blog.articles
      end
    end
  end
end
