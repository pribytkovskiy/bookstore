require 'spec_helper'

RSpec.describe Checkout::Checkout, type: :interactor do
  let(:order) { create(:order_address) }

  describe '.call' do
    before { allow(Checkout::AddressOrder).to receive(:call) { true } }
    subject(:context) { Checkout::Checkout.call(id: order.id) }

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'when OrdersController::ORDER_STATE[:address]' do
      expect(Checkout::Checkout.call(id: order.id)).to eq(true)
    end
  end
end
