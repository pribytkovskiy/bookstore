require 'spec_helper'

RSpec.describe Checkout::ShowOrder, type: :interactor do
  let(:user) { create(:user) }
  let(:order) { create(:order_address) }

  before do
    order.user = user
    order.save
  end

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { Checkout::ShowOrder.call(id: order.id) }

      it 'succeeds' do
        expect(context).to be_a_success
        expect(context.billing_address).not_to be_nil
        expect(context.shipping_address).not_to be_nil
        expect(context.delivery).not_to be_nil
        expect(context.card).not_to be_nil
      end
    end
  end
end
