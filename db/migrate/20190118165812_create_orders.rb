class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.string :card_number
      t.string :name_on_card
      t.string :mm_yy
      t.string :cvv
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_zip
      t.string :shipping_country
      t.string :shipping_phone
      t.string :state
      t.integer :subtotal
      t.integer :cupon_id
      t.integer :delivery_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
