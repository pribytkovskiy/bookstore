require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { expect have_many(:comments).dependent(:destroy) }
    it { expect have_many(:addresses).dependent(:destroy) }
    it { expect have_many(:orders) }
  end

  describe "role" do
    it 'admin' do
      user = create(:user)
      expect(user.role?(:admin)).to be_truthy
    end

    it 'not admin' do
      expect(subject.role?(:admin)).to be_falsey
    end
  end
end

