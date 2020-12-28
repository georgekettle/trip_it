class AddLocationToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :location, null: false, foreign_key: true
  end
end
