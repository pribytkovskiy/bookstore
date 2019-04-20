require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { validate_presence_of :category }
    it { validate_uniqueness_of :category }
  end

  describe 'associations' do
    it { have_many(:products) }
  end
end
