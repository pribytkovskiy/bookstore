require 'rails_helper'

describe OrderItem, type: :model do

  context 'association' do
    it { expect belong_to :product }
    it { expect belong_to :order }
  end

  context 'validation' do
    it do
      expect validate_numericality_of(:quantity).is_greater_than(1)
      puts validate_numericality_of(:quantity)
    end
  end

  context 'total_price' do
    subject { create(:order_item) }

    it '#total_price' do
      expect(subject.total_price).to eq(subject.product.price * subject.quantity)
    end
  end
end
