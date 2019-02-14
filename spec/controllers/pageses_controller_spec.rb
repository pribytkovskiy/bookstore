require 'rails_helper'

RSpec.describe PagesController do
  TEST_PARAMETER = 'test_parameter'.freeze

  describe 'GET #home' do
    before { get :home }

    it 'renders pages/home template' do
      expect(response).to render_template 'pages/home'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'assigns @favorites' do
      expect(assigns(:favorites)).not_to be_nil
    end
  end

  describe 'GET #catalog' do
    let(:quantity_bestsellers) { 2 }
    let(:latest_default_quantity) { 1 }

    before do
      stub_const('PagesController::QUANTITY_BESTSELLERS', quantity_bestsellers)
      stub_const('PagesController::LATEST_DEFAULT_QUANTITY', latest_default_quantity)
      get :catalog
    end

    it 'renders pages/catalog template' do
      expect(response).to render_template 'pages/catalog'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
    
    it 'assigns @products' do
      expect(assigns(:products)).not_to be_nil
    end

    it 'assigns @sort_products' do
      expect(assigns(:sort_products)).not_to be_nil
    end
  end
end
