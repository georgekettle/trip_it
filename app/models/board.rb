class Board < ApplicationRecord
  has_many :board_users, dependent: :destroy
  has_many :users, through: :board_users
  has_one :post
  has_many :saves, dependent: :destroy
  has_many :posts, through: :saves
  has_many :photos, through: :posts
end
