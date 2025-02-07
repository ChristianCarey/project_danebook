class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
