class AddAuthorToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :author_id, :integer
  end
end
