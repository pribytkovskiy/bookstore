require 'rails_helper'

RSpec.describe Delivery, type: :model do
  describe 'associations' do
    it { have_many :order }
  end
end
