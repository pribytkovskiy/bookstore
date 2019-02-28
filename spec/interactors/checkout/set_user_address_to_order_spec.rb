require 'spec_helper'

RSpec.describe Checkout::SetUserAddressToOrder, type: :interactor do
  let(:user) { create(:user, :for_checkout_page) }
  let(:order) { user.orders.first }

  describe '.call' do
    context 'when given valid credentials' do
      subject(:context) { Checkout::SetUserAddressToOrder.call(id: order.id) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'user address exist' do
        expect(context.address).not_to eq(nil)
      end
    end
  end
end
