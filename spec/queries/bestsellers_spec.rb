require 'rails_helper'

RSpec.describe Bestsellers do
  let!(:orders) { create(:order, :with_items) }

  context 'response query' do
    it '1 product in query' do
      expect(Bestsellers.call(1).size.size).to eq(1)
    end

    it '2 product in query' do
      expect(Bestsellers.call(2).size.size).to eq(2)
    end
  end
end
