require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'associations' do
    it { expect belong_to :addressable }
  end

  context 'enum' do
    it { expect define_enum_for(:address_type).with([ :billing, :shipping ]) }
  end

  context 'scopes' do
    it 'search_billing' do
      expect(Address.search_billing.where_values_hash).to eq("address_type"=>:billing)
    end

    it 'search_shipping' do
      expect(Address.search_shipping.where_values_hash).to eq("address_type"=>:shipping)
    end
  end
end
