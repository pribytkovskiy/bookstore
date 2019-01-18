class CuponAdd < ActiveRecord::Migration[5.2]
  def change
    create_table :cupons do |t|
      t.integer :number
      t.integer :price

      t.timestamps
    end
  end
end
