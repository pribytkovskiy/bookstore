require 'rails_helper'

RSpec.describe Bestsellers do
  
  context 'returns 4 books' do
    it 'sorts' do
      expect(described_class.call).to eq([])
    end
  end
end
