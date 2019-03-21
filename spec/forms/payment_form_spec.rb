require 'rails_helper'

RSpec.describe PaymentForm, type: :model do
  context 'when validation' do
    %i[name card_number cvv].each do |attribute_name|
      it { validate_presence_of(attribute_name) }
    end

    it { validate_length_of(:name).is_at_most(50) }
    it { validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
  end
end
