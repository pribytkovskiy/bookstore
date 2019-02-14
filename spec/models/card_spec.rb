require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "associations" do
    it { expect belong_to :order }
  end
end
