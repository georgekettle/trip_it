class Post < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :board
end
