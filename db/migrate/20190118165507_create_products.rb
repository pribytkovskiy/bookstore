class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.string :image_url
      t.decimal :price
      t.text :description
      t.date :date
      t.string :dimensions
      t.string :materials
      t.integer :views, default: 0
      t.references :author, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
