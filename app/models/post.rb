class Post < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  belongs_to :location
  has_many :saves, dependent: :destroy
  has_many :boards, through: :saves

  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :photo

  after_create :create_save

  # validates :location, :photo, presence
  validates :photo, :location, :presence => true

  def photo_popularity
    self.photo.post_count
  end

  def photo_url
    self.photo.image.service_url
  end

  def featured_board
    # right now just picking first one - change to measure popularity of board perhaps
    self.saves.first.board
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

  private

  def create_save
    Save.create(post_id: self.id, board_id: self.board_id)
  end
end
