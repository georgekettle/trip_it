class AddCloudinaryIdToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :cloudinary_id, :string, null: false
  end
end
