module Checkout
  class CreateOrder < ApplicationService
    attr_reader :state, :coupon_id
    
    def initialize(state, coupon_id)
      @state = state
      @coupon_id = coupon_id
    end

    def call
      Order.create(state: @state, coupon_id: @coupon_id)
    end
  end
end