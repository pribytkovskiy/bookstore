require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
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

  describe 'PATCH #update' do
    let(:results) { instance_double('Result', billing_address: 'billing_address',
                                    shipping_address: 'shipping_address',
                                    delivery: 'delivery',
                                    card: 'card',
                                    failure?: false) }

    before do
      allow(Checkout::UpdateOrder).to receive(:call).and_return(results)
    end

    it 'assigns the requested order to @result' do
      expect(assigns(:result)).to eq nil
    end
  end
end