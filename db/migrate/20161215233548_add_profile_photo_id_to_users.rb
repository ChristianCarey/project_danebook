class AddProfilePhotoIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_photo_id, :integer
  end
end
