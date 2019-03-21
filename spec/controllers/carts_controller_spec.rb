require 'rails_helper'

RSpec.describe CartsController do
  let(:user) { create(:user, :with_orders_address) }
  let!(:order) { user.orders.first }

  before do
    allow(controller).to receive(:check_order_items?).and_return(false)
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: order.id }
    end

    it 'renders carts/show template' do
      expect(response).to render_template 'carts/show'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #update' do
    let(:coupon) { create(:coupon) }

    before do
      sign_in user
      patch :update, params: { id: order.id, order: { number: coupon.number } }
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to redirect_to cart_path
    end
  end
end
