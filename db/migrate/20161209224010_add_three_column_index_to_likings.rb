class AddThreeColumnIndexToLikings < ActiveRecord::Migration[5.0]
  def change
    remove_index :likings, [:user_id, :likable_id]
    add_index    :likings, [:user_id, :likable_id, :likable_type], unique: true
  end
end
