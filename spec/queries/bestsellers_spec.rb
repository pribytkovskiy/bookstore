require 'rails_helper'

RSpec.describe Bestsellers do
  let!(:order) { create(:order, :with_items) }

  context 'when response query' do
    it '1 product in query' do
      expect(described_class.call(1).size.size).to eq(1)
    end

    it '2 product in query' do
      expect(described_class.call(2).size.size).to eq(2)
    end
  end
end
