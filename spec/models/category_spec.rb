require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it { expect validate_presence_of :category }
    it { expect validate_uniqueness_of :category }
  end

  describe "associations" do
    it { expect have_many(:products) }
  end
end
