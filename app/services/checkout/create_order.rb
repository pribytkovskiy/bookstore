module Checkout
  class CreateOrder < ApplicationService
    attr_reader :order, :user_id, :coupon_id
    
    def initialize(order, user_id, coupon_id = 1)
      @order = order
      @user_id = user_id
      @coupon_id = coupon_id
    end

    def call
      order = Order.new(state: OrdersController::ORDER_STATE[:address], coupon_id: coupon_id || 1, user_id: user_id)
      order.save(validate: false)
      @order.set_order_id_to_order_items(order.id)
      order
    end
  end
end
