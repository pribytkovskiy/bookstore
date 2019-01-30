module Checkout
  class CreateOrder < ApplicationService
    attr_reader :cart, :user_id, :coupon_id
    
    def initialize(cart, user_id, coupon_id = 1)
      @cart = cart
      @user_id = user_id
      @coupon_id = coupon_id
    end

    def call
      order = Order.new(state: OrdersController::ORDER_STATE[:address], coupon_id: coupon_id || 1, user_id: user_id)
      order.save(validate: false)
      @cart.set_order_id_to_line_items(order.id)
      order
    end
  end
end
