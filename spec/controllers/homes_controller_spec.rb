require 'rails_helper'

RSpec.describe HomesController do
  describe 'GET #home' do
    before { get :show }

    it 'renders homes/show template' do
      expect(response).to render_template 'homes/show'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'assigns @slide' do
      expect(assigns(:slide)).not_to be_nil
    end

    it 'assigns @bestsellers' do
      expect(assigns(:bestsellers)).not_to be_nil
    end
  end
end
