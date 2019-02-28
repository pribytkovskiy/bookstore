require 'spec_helper'

RSpec.describe OrderItem::UpdateOrderItem, type: :interactor do
  let(:order) { create(:order, :with_items) }
  let(:order_item) { order.order_items.first }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { OrderItem::UpdateOrderItem.call(id: order_item.id, type: :add) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'add order item' do
        expect { OrderItem::UpdateOrderItem.call(id: order_item.id, type: 'add') }.to change{ order_item.quantity }.by(1)
      end

      it 'minus order item' do
        expect { OrderItem::UpdateOrderItem.call(id: order_item.id, type: 'minus') }.to change{ order_item.quantity }.by(1)
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { OrderItem::UpdateOrderItem.call(id: nil) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
