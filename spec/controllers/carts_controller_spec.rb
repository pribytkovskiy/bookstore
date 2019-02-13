require 'rails_helper'

RSpec.describe CartsController do

  describe 'GET #show' do
    let(:order) { create(:order, :with_items) }
    let(:order_item) { create_list(:order_item, 2) }

    before do 
      allow(order).to receive(:order_items).and_return(order_item)
      get :show, params: { id: order.id }
    end

    it 'renders carts/show template' do
      expect(response).to render_template 'cart/show'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #update' do
    let(:coupon) { create(:coupon) }

    before do
      get :update, params: { id: coupon.number, order: { nubmer: coupon.number } }
    end

    it 'renders carts/show template' do
      expect(response).to render_template 'cart/show'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
  