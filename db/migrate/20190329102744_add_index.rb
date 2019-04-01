class AddIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :cards, :order_id
    add_index :orders, :user_id
    add_index :orders, :delivery_id
    add_index :orders, :coupon_id
    add_index :orders, :card_id
    add_index :coupons, :number
  end
end
