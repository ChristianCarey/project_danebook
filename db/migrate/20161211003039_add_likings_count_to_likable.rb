class AddLikingsCountToLikable < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :likings_count, :integer
    add_column :comments, :likings_count, :integer
  end
end
