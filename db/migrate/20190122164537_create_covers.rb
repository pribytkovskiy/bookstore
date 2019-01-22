class CreateCovers < ActiveRecord::Migration[5.2]
  def change
    create_table :covers do |t|
      t.string :image_url
      t.integer :product_id, index: true

      t.timestamps
    end
  end
end