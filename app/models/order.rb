class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :cards, optional: true
  has_many :addresses
  has_many :order_items

  def total_price
    order_items.sum(&:total_price)
  end
end
