class Location < ApplicationRecord
  belongs_to :post
  validates :longitude, :latitude, :post, presence: true

  def coordinates
    [self.longitude, self.latitude]
  end
end
