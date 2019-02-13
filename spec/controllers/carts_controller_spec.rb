require 'rails_helper'

RSpec.describe CartsController do

  describe 'GET #show' do

    before do 
      get :show, params: { id: 1 }
      create(:order, :with_items)
    end

    it 'renders carts/show template' do
      expect(response).to render_template 'cart/show'
    end

    it 'renders pages/home template if not order_items' do
      expect(response).to render_template 'pages/home'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #update' do
    before { get :update, params: { id: 1 } }

    it 'renders carts/update template' do
      expect(response).to render_template 'cart/update'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
