class AddStateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :state, :boolean
  end
end
