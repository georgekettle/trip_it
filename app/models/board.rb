class Board < ApplicationRecord
  has_many :board_users, dependent: :destroy
  has_many :users, through: :board_users
  has_many :posts, dependent: :destroy
  has_many :photos, through: :posts
end
