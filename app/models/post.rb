class Post < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :board
  belongs_to :location

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :board
  accepts_nested_attributes_for :photo

  # validates :location, :photo, presence
  validates :photo, :location, :presence => true

  def photo_popularity
    self.photo.post_count
  end

  def photo_url
    self.photo.image.service_url
  end

  def to_json(options={})
    super(:include => [
      :location,
      {
        :photo => {
          :include => {
            :image => {
              :methods => :service_url
              # :include => :service_url
            }
          }
        }
      }]
    )
  end
end
