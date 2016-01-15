require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { Fabricate :user }
  let!(:blog) { Fabricate :blog, link: 'www.testxx.com' }
  let!(:subscription) { Fabricate :subscription, user: user, blog: blog }

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
    let(:valid_params) { { blog_link: 'www.testxx.com', blog_name: 'testxx' } }

    it 'creates a new subscription if not subscibing' do
      expect {
        post :create, subscription: valid_params
      }.to change { Subscription.count }.by 1
    end

    it 'doesnt create a new subscription if subscibing' do
      Fabricate :subscription, user: user, blog_name: 'testxx', blog_link: 'www.testxx.com'
      expect {
        post :create, subscription: valid_params
      }.not_to change { Subscription.count }
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the subscription' do
      subscription = Fabricate :subscription, user: user, blog_name: 'testxx', blog_link: 'www.testxx.com'
      expect {
        delete :destroy, id: subscription.id
      }.to change { Subscription.count }.by -1
    end
  end

  describe 'GET #edit' do
    it "assigns the subscription" do
      get :edit, { id: subscription.id }
      expect(assigns(:subscription)).to eq subscription
    end
  end

  describe 'PATCH #update' do
    let!(:blog) { Fabricate :blog, link: 'www.testxx1.com' }
    let(:valid_params) { Fabricate.attributes_for :subscription, blog_name: 'new' }
    let(:invalid_params) { Fabricate.attributes_for :subscription, blog_name: nil }

    context 'with valid params' do
      it 'updates the blog_name of subscription' do
        patch :update, id: subscription.id, subscription: valid_params
        expect(subscription.reload.blog_name).to eq 'new'
      end
    end

    context 'with invalid params' do
      it 'updates the blog_name of subscription' do
        expect {
          patch :update, id: subscription.id, subscription: invalid_params
        }.not_to change { subscription.reload.blog_name }
      end
    end
  end

end
