class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :quantity
      t.decimal :price
      t.text :description
      t.date :year
      t.string :dimensions
      t.string :materials
      t.references :category, index: true

      t.timestamps
    end

    create_table :author_products, id: false do |t|
      t.references :author, index: true
      t.references :product, index: true
    end
  end
end
