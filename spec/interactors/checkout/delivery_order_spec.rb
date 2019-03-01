require 'spec_helper'

RSpec.describe Checkout::DeliveryOrder, type: :interactor do
  let(:order) { create(:order_address) }
  let(:delivery) { create(:delivery) }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { Checkout::DeliveryOrder.call(id: order.id, delivery: { id: delivery.id }) }

      before do
        order.state = :delivery_method
        order.save
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).to eq(nil)
      end
    end
  end
end
 