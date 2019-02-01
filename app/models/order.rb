class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery, optional: true
  belongs_to :coupon, optional: true
  belongs_to :cards, optional: true
  has_many :addresses
  has_many :line_items

  validates :card_number, length: { minimum: 10 },
            format: { with: /\A[0-9]+\z/, message: 'please enter a valid credit card number' }
  validates :name_on_card, length: { maximum: 50 }, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/,
            message: 'the expiration date must be MM/YY' }
  validates :cvv, length: { maximum: 4 }

  def add_product(product_id, quantity = '1')
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = line_items.build(product_id: product_id)
      current_item.quantity = quantity.to_i
    end
    current_item.save
  end

  def del_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      return (current_item.quantity -= 1) if current_item.quantity > 1

      current_item.destroy
    end
    current_item.save
  end

  def destroy_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    current_item.destroy
  end

  def total_price
    line_items.map { |line_item| line_item.total_price }.sum
  end

  def set_order_id_to_line_items(order_id)
    line_items.map do |line_item|
      line_item.order_id = order_id
      line_item.save
    end
  end
end
