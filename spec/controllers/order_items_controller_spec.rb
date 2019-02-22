require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:order) { create(:order, :with_items) }
  let(:product) { create(:product) }

  describe 'POST #create' do
    it 'create order item' do
      post :create, params: { order_id: order.id, product_id: product.id, redirect_to: store_path }
      expect(response).to redirect_to store_path
    end
  end

  describe 'PATCH #update' do
    it 'plus order item' do
      patch :update, params: { 
        id: order.order_items.first.id, type: OrderItemsController::COMMANDS[:add], redirect_to: store_path
      }
      expect(response).to redirect_to store_path
    end

    it 'minus order item' do
      patch :update, params: { 
        id: order.order_items.first.id, type: OrderItemsController::COMMANDS[:delete], redirect_to: store_path
      }
      expect(response).to redirect_to store_path
    end
  end

  describe "POST #destroy" do
    it "destroy order item" do
      delete :destroy, params: { id: order.order_items.first.id }
      expect(response).to redirect_to cart_path
    end
  end
end
