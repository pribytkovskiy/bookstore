require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:orders) }
  end

  describe "role" do
    it 'admin' do
      user = create(:user)
      expect(user.admin?).to be_truthy
    end

    it 'not admin' do
      expect(subject.admin?).to be_falsey
    end
  end
end
