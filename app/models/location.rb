class Location < ApplicationRecord
  has_many :posts
  validates :longitude, :latitude, presence: true
  validates :latitude, uniqueness: { scope: :longitude }

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :address_changed?

  def coordinates
    [self.longitude, self.latitude]
  end
end
