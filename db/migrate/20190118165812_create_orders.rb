class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :state
      t.decimal :subtotal
      t.integer :card_id
      t.integer :coupon_id
      t.integer :delivery_id
      t.integer :user_id

      t.timestamps
    end
  end
end
