require 'spec_helper'

RSpec.describe OrderItem::CreateOrderItem, type: :interactor do
  let(:order) { create(:order, :with_items) }
  let(:product) { create(:product) }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { OrderItem::CreateOrderItem.call(order_id: order.id, product_id: product.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'create order item' do
        expect(OrderItem.last.product_id).to eq(product.id)
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { OrderItem::CreateOrderItem.call(order_id: nil, product_id: product.id) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
 