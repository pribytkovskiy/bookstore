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
      subject(:context) { Checkout::AddressOrder.call(order_id: order.id, address_form: nil) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).to exist 
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { Checkout::AddressOrder.call(order_id: order.id, address_form: true) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
