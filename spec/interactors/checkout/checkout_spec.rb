require 'spec_helper'

RSpec.describe Checkout::Checkout, type: :interactor do
  let(:order) { create(:order_address) }

  describe '.call' do
    subject(:context) { Checkout::Checkout.call(id: order.id) }

    it 'succeeds' do
      expect(context).to be_a_success
    end
  end
end
