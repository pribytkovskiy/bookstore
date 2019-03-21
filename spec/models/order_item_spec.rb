require 'rails_helper'

describe OrderItem, type: :model do
  context 'when association' do
    it { belong_to :product }
    it { belong_to :order }
  end

  context 'when validation' do
    it do
      validate_numericality_of(:quantity).is_greater_than(1)
      validate_numericality_of(:quantity)
    end
  end

  context 'when total_price' do
    subject { create(:order_item) }

    it '#total_price' do
      expect(subject.total_price).to eq(subject.product.price * subject.quantity)
    end
  end
end
