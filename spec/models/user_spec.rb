require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { have_many(:comments).dependent(:destroy) }
    it { have_many(:addresses).dependent(:destroy) }
    it { have_many(:orders) }
  end

  describe 'role' do
    it 'admin' do
      user = create(:user)
      expect(user.role?(:admin)).to be_truthy # rubocop:disable RSpec/PredicateMatcher
    end

    it 'not admin' do
      expect(subject.role?(:admin)).to be_falsey # rubocop:disable RSpec/PredicateMatcher
    end
  end
end
