require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'associations' do
    it { expect belong_to :product }
  end
end
