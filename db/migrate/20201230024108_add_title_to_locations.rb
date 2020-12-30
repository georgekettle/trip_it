class AddTitleToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :title, :string, default: "", null: false
  end
end
