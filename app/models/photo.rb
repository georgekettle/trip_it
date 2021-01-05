class Photo < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_many :posts
  before_destroy :cleanup

  validate :image?

  def post_count
    self.posts.count
  end

  private

  def cleanup
    count = self.posts.count
    if count == 1
      self.posts.destroy_all
      # also destroy photo from cloudinary
      Cloudinary::Api.delete_resources([self.image.key])
    elsif count >= 2
      errors.add(:base, "Cannot destroy photo if more than one post references this photo")
      throw(:abort)
    end
  end

  def image?
    errors.add(:image, "can't be blank") unless image.attached?
  end
end
