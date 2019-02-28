require 'rails_helper'

RSpec.describe CommentsController do
  TEST_PARAMETER = 'test_parameter'.freeze

  describe 'GET #create' do
    let(:comment) { create(:comment) }
    let(:product) { comment.product }

    before { post :create, params: { comment: attributes_for(:comment) } }

    it 'renders prodcuts/show template' do
      expect(response).to redirect_to product_path(id: 1)
    end

    it 'responds successfully with an HTTP 302 status code' do
      expect(response).to have_http_status(302)
    end
  end
end
