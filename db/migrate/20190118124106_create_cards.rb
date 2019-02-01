class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :name_on_card
      t.string :mm_yy
      t.string :cvv

      t.timestamps
    end
  end
end
