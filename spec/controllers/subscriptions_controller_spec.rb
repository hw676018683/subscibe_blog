require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { Fabricate :user }
  let!(:blog) { Fabricate :blog, link: 'www.testxx.com' }
  let(:subscription) { Fabricate :subscription, user: user, blog: blog }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "assigns the subscription" do
      get :show, { id: subscription.id }
      expect(assigns(:subscription)).to eq subscription
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    it 'creates a new subscription if not subscibing' do
      expect {
        post :create, link: blog.link
      }.to change { Subscription.count }.by 1
    end

    it 'doesnt create a new subscription if subscibing' do
      user.subscibe blog
      expect {
        post :create, link: blog.link
      }.not_to change { Subscription.count }
    end

    it 'creates a new blog if blog not existing' do
      expect {
        post :create, link: 'www.new.com'
      }.to change { Blog.count }.by 1
    end

    it 'doesnt create a new blog if blog exists' do
      expect {
        post :create, link: blog.link
      }.not_to change { Blog.count }
    end
  end

end
