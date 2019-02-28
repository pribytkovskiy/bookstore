require 'spec_helper'

RSpec.describe OrderItem::DestroyOrderItem, type: :interactor do
  let(:order) { create(:order, :with_items) }
  let(:order_item) { order.order_items.first }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { OrderItem::DestroyOrderItem.call(id: order_item.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'destroy order item' do
        expect(order.order_items.second).to eq(nil)
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { OrderItem::DestroyOrderItem.call(id: nil) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
