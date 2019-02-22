require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, :with_orders_address) }
  before { sign_in user } 

  describe 'GET #index' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
    end

    it 'assigns @orders' do
      expect(assigns(:orders)).not_to be_nil
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #update' do
    before do
      patch :update, params: { id: user.orders.first.id }
    end

    it 'assigns the requested order to @order' do
      expect(assigns(:order)).to eq Order.last
    end

    it 'product should be decorated' do
      expect(assigns(:order)).to be_decorated
    end

    it 'renders the :show template' do
      expect(response).to redirect_to order_path
    end
  end
end