require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #show' do
    let(:product) { create(:product) }

    before do
      session[:return_to] = 'home_page'
      get :show, params: { id: product }
    end
    
    it 'assigns the requested product to @product' do
      expect(assigns(:product)).to eq product
    end

    it 'assigns @reviews' do
      expect(assigns(:reviews)).not_to be_nil
    end

    it 'product should be decorated' do
      expect(assigns(:product)).to be_decorated
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end

    it 'session[:return_to]' do
      expect(session[:return_to]).to eq('home_page')
    end
  end
end