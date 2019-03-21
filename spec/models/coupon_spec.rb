require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'when associations' do
    it { have_many :order }
  end
end
