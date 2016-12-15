class AddLikingsCountToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :likings_count, :integer
  end
end
