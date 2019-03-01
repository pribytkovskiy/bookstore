require 'spec_helper'

RSpec.describe Checkout::AddressOrder, type: :interactor do
  let(:user) { create(:user) }
  let(:order) { create(:order_address) }

  before do
    order.user = user
    order.save
  end

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { Checkout::AddressOrder.call(id: order.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).to be_truthy
      end
    end
  end
end
