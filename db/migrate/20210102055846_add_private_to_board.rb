class AddPrivateToBoard < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :private, :boolean, null: false, default: false
  end
end
