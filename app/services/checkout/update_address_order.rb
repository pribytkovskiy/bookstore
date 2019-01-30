module Checkout
  class UpdateAddressOrder < ApplicationService
    PARAMS = %w(first_name last_name address city zip country phone shipping_first_name shipping_last_name shipping_address shipping_city shipping_zip shipping_country shipping_phone).freeze

    attr_reader :order, :current_user
    
    def initialize(order, current_user)
      @order = order
      @current_user = current_user
    end

    def call
      copy_order_params
      order.state = OrdersController::ORDER_STATE[:delivery]
      order.save
    end

    private

    def copy_order_params
      PARAMS.each do |param|
        eval("order.#{param} = current_user.#{param}")
      end
    end
  end
end
