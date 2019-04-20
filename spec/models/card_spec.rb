require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'associations' do
    it { belong_to :order }
  end
end
