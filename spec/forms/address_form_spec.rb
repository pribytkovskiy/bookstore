require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  context 'validation' do
    %i(first_name last_name address zip country phone city shipping_first_name shipping_last_name shipping_address
      shipping_city shipping_zip shipping_country shipping_phone).each do |attribute_name|
      it { expect validate_presence_of(attribute_name) }
    end

    it { expect validate_length_of(:zip).is_at_most(5) }

    it { expect validate_length_of(:phone).is_at_most(15) }

    %i(first_name last_name address city country phone shipping_first_name shipping_last_name shipping_address
      shipping_city shipping_country shipping_phone).each do |attribute_name|
      it { expect validate_length_of(attribute_name).is_at_most(50) }
    end
  end
end
