class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    self.product.price * self.quantity
  end
end
