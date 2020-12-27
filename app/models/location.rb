class Location < ApplicationRecord
  belongs_to :post
  validates :longitude, :latitude, :post, presence: true
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :address_changed?

  def coordinates
    [self.longitude, self.latitude]
  end
end
