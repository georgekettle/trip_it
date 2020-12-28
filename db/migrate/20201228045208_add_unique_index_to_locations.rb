class AddUniqueIndexToLocations < ActiveRecord::Migration[6.0]
  def change
    add_index :locations, [:latitude, :longitude], unique: true
  end
end
