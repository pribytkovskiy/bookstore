require 'spec_helper'

RSpec.describe Checkout::ConfirmationOrder, type: :interactor do
  let(:order) { create(:order_address) }

  describe '.call' do
    before do
      allow(Checkout::AddressOrder).to receive(:call).and_return(true)
      order.state = :confirmation
      order.save
    end

    subject(:context) { Checkout::ConfirmationOrder.call(id: order.id, complete: true) }

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'when OrdersController::ORDER_STATE[:address]' do
      expect(context.complete).to eq(true)
    end
  end
end
