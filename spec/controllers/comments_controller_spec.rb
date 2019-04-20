require 'rails_helper'

RSpec.describe CommentsController do
  describe 'GET #create' do
    let(:comment) { create(:comment) }
    let(:product) { comment.product }
    let(:user) { comment.user }

    before { sign_in user }

    it 'change comments size' do
      expect { post :create, params: { comment: attributes_for(:comment) } }.to change { product.comments.size }.by(0)
    end

    it 'responds successfully with an HTTP 302 status code' do
      expect(response).to have_http_status(200)
    end
  end
end
