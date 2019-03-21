require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:user) { create(:user) }
  let(:users_address_shipping) { create(:users_address, :shipping) }
  let(:users_address_billing) { create(:users_address, :billing) }

  before do
    sign_in user
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #index' do
    before { get :index, params: { user_id: user.id } }

    it 'renders settings/index template' do
      expect(response).to render_template 'settings/index'
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'assigns @billing_address and @shipping_address' do
      expect(assigns(:billing_address)).not_to be_nil
      expect(assigns(:shipping_address)).not_to be_nil
    end
  end

  describe 'POST #create' do
    let(:bed_phone) { 123 }

    it 'redirect to the edit' do # rubocop:disable RSpec/ExampleLength
      post :create, params: {
        billing: {
          first_name:          users_address_billing.first_name,
          last_name:           users_address_billing.last_name,
          address:             users_address_billing.address,
          city:                users_address_billing.city,
          zip:                 users_address_billing.zip,
          country:             users_address_billing.country,
          phone:               bed_phone,
          user_id:             users_address_shipping.addressable_id,
          address_type:        :billing
        },
        shipping: {
          first_name:          users_address_shipping.first_name,
          last_name:           users_address_shipping.last_name,
          address:             users_address_shipping.address,
          city:                users_address_shipping.city,
          zip:                 users_address_shipping.zip,
          country:             users_address_shipping.country,
          phone:               bed_phone,
          user_id:             users_address_shipping.addressable_id,
          address_type:        :shipping
        },
        user_id: users_address_shipping.addressable_id,
        id: user.id
      }
      expect(response).to have_http_status(200)
    end

    describe 'when address exist' do
      before do
        users_address_shipping.addressable_id = user.id
        users_address_billing.addressable_id = user.id
        get :index, params: { user_id: users_address_shipping.addressable_id, id: user.id }
      end

      it 'view user address' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
