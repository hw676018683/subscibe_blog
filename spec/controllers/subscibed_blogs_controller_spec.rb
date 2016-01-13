require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { Fabricate :user }
  let(:blog) { Fabricate :blog }
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

end
