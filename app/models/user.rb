class User < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy
  has_many :posts
  has_many :board_users
  has_many :boards, :through => :board_users
  validates :username, presence:true, uniqueness: {case_sensitive: false}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def format_username
    '@' + self.username
  end
end
