class CouponAdd < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.integer :number
      t.integer :price

      t.timestamps
    end
  end
end
