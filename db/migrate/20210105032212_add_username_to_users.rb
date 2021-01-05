class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, null: false, unique: true
    add_index :users, :username, unique: true
  end
end
