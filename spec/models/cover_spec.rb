require 'rails_helper'

RSpec.describe Coupon, type: :model do # rubocop:disable RSpec/FilePath
  context 'when associations' do
    it { belong_to :product }
  end
end
