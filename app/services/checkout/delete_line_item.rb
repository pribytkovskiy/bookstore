module Checkout
  class DeleteLineItem < ApplicationService
    attr_reader :product_id
    
    def initialize(product_id)
      @product_id = product_id
    end

    def call
      current_item = line_items.find_by(product_id: @product_id)
      if current_item
        return (current_item.quantity -= 1) if current_item.quantity > 1
    
        current_item.destroy
      end
      current_item
    end
  end
end