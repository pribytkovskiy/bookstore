require 'spec_helper'

RSpec.describe Checkout::UpdateOrder, type: :interactor do
  let(:user) { create(:user) }
  let(:order) { create(:order_address) }

  before do
    order.user = user
    order.save
  end

  describe '.call' do
    context 'delivery' do
      subject(:context) { Checkout::UpdateOrder.call(id: order.id, step: :delivery) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end

    context 'payment' do
      let(:card) { create(:card) }

      subject(:context) { Checkout::UpdateOrder.call(id: order.id,
                                                     step: :payment,
                                                     card_number: card.card_number,
                                                     name_on_card: card.name_on_card,
                                                     mm_yy: card.mm_yy,
                                                     cvv: card.cvv,
                                                     order_id: order.id) }
      subject(:fail_context) { Checkout::UpdateOrder.call(id: order.id, step: :payment, params: card) }

      it 'succeeds' do
        expect(context).to be_a_success
        expect(context.card).not_to be_nil
      end

      it 'not succeeds' do
        expect(fail_context).to_not be_a_success
        expect(fail_context.card).not_to be_nil
      end
    end

    context 'confirmation' do
      subject(:context) { Checkout::UpdateOrder.call(id: order.id, step: :confirmation) }

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end
  end
end
