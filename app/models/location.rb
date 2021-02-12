class Location < ApplicationRecord
  has_many :posts
  has_many :photos, -> { distinct }, through: :posts
  validates :longitude, :latitude, presence: true
  validates :latitude, uniqueness: { scope: :longitude }

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :address_changed?

  def coordinates
    [self.longitude, self.latitude]
  end

  def photo_count_formatted
    pluralized = self.photos.count == 1 ? "photo" : "photos"
    "#{self.photos.count} #{pluralized}"
  end
end
