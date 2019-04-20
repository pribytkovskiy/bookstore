class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_price
    product.price * quantity
  end

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
