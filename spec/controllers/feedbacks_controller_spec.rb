require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let(:user) { Fabricate :user, email: 'admin@admin.com' }
  let!(:feedback) { Fabricate :feedback, content: 'content' }

  before do
    Settings[:admin_emails] = ['admin@admin.com']
    sign_in user
  end

  describe 'GET index' do
    it 'assigns the feedbacks' do
      get :index
      expect(assigns(:feedbacks)).to match_array [feedback]
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the feedback' do
      expect {
        delete :destroy, id: feedback.id
      }.to change { Feedback.count }.by -1
    end
  end
end
