class Post < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :board
  has_many :locations, inverse_of: :post

  accepts_nested_attributes_for :locations, allow_destroy: true, limit: 2

  # validates :location, :photo, presence
  validates :photo, :presence => true
  validate :has_location

  def has_location
    errors.add(:location, 'cannot be blank') if self.locations.blank?
  end
end
