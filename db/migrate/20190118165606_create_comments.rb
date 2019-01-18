class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.string :comments
      t.integer :rate
      t.belongs_to :user, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
