class Photo < ApplicationRecord
  has_many :posts
  before_destroy :cleanup

  def post_count
    self.posts.count
  end

  private

  def cleanup
    count = self.posts.count
    if count == 1
      self.posts.destroy_all
      # also destroy photo from cloudinary
      Cloudinary::Api.delete_resources([self.cloudinary_id])
    elsif count >= 2
      errors.add(:base, "Cannot destroy photo if more than one post references this photo")
      throw(:abort)
    end
  end
end
