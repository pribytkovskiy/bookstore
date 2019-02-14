require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "associations" do
    it { expect have_many :order }
  end
end
