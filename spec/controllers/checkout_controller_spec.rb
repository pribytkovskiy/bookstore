require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user, :with_orders_address) }

  before { sign_in user }

  describe 'PATCH #update' do
    # rubocop:disable Metrics/LineLength
    let(:results) { instance_double('Result', billing_address: 'billing_address', shipping_address: 'shipping_address', delivery: 'delivery', card: 'card', failure?: false) }
    # rubocop:enable Metrics/LineLength

    before do
      allow(Checkout::UpdateOrder).to receive(:call).and_return(results)
    end

    it 'assigns the requested order to @result' do
      expect(assigns(:result)).to eq nil
    end
  end
end
