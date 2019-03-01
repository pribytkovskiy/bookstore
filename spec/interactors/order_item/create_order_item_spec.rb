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
    end
  end
end
 