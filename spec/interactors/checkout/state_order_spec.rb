require 'spec_helper'

RSpec.describe Checkout::StateOrder, type: :interactor do
  let(:order) { create(:order_address) }

  describe '.call' do
    subject(:context) { described_class.call(id: order.id) }

    it 'succeeds' do
      expect(context).to be_a_success
    end
  end
end
