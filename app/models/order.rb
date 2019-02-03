class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :cards, optional: true
  has_many :addresses
  has_many :order_items

  def add_product(product_id, quantity = '1')
    current_item = order_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = order_items.build(product_id: product_id)
      current_item.quantity = quantity.to_i
    end
    current_item.save
  end

  def del_product(product_id)
    current_item = order_items.find_by(product_id: product_id)
    if current_item
      return (current_item.quantity -= 1) if current_item.quantity > 1

      current_item.destroy
    end
    current_item.save
  end

  def destroy_product(product_id)
    current_item = order_items.find_by(product_id: product_id)
    current_item.destroy
  end

  def total_price
    order_items.sum(&:total_price)
  end

  def set_order_id_to_order_items(order_id)
    order_items.map do |order_item|
      order_item.order_id = order_id
      order_item.save
    end
  end
end
