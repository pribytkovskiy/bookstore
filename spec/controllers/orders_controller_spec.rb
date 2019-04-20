require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { create(:order, user: user) }

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

  describe 'GET #show' do
    before do
      get :show, params: { id: order.id }
    end

    it 'renders carts/show template' do
      expect(response).to render_template :show
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
