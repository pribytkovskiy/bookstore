require 'spec_helper'

RSpec.describe Checkout::AddressOrder, type: :interactor do
  let(:user) { create(:user) }
  let(:order) { create(:order_address) }
  let(:address_form) { instance_double('AddressForm') }

  before do
    allow(address_form).to receive(:permit!).and_return(true)
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
        expect(context.address).to exist 
      end
    end

    context 'when given invalid credentials' do
      subject(:context) { Checkout::AddressOrder.call(id: order.id, address_form: address_form) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to be_present
      end
    end
  end
end
