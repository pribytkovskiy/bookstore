class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_zip
      t.string :shipping_country
      t.string :shipping_phone
      t.string :order_id
      t.string :user_id
      t.string :type

      t.timestamps
    end
  end
end
