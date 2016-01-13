require 'rails_helper'

RSpec.describe SubscibedBlogsController, type: :controller do
  let(:user) { Fabricate :user }
  let(:blog) { Fabricate :blog }
  let(:user_blog) { Fabricate :user_blog, user: user, blog: blog }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "assigns the user_blog" do
      get :show, { id: user_blog.id }
      expect(assigns(:subscibed_blog)).to eq user_blog
    end
  end

end
