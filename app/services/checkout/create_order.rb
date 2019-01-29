module Checkout
  class CreateOrder < ApplicationService
    attr_reader :state, :user_id, :coupon_id
    
    def initialize(state, user_id, coupon_id = 1)
      @state = state
      @user_id = user_id
      @coupon_id = coupon_id
    end

    def call
      Order.create!(state: state, coupon_id: coupon_id, user_id: user_id)
    end
  end
end