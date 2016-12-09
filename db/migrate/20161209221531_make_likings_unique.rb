class MakeLikingsUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :likings, [:user_id, :likable_id], unique: true
  end
end
