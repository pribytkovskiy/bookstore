require 'rails_helper'

RSpec.describe ProductsController do
  TEST_PARAMETER = 'test_parameter'.freeze

  describe 'GET #show' do
    before do
      stub_const('ProductsController::NAME_DEFAULT_PARAM_SORT', TEST_PARAMETER)
      get :show
    end

    it 'renders products/show template' do
      expect(response).to render_template 'products/show'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'assigns @categories' do
      expect(assigns(:categories)).not_to be_nil
    end

    it 'assigns @name_sort' do
      expect(assigns(:name_sort)).not_to be_nil
    end

    it 'assigns @products' do
      expect(assigns(:products)).not_to be_nil
    end
  end
end
