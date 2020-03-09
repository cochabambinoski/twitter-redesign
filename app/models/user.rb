class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  validates :fullname, presence: true, length: { maximum: 20 }
  validates :username, presence: true, length: { maximum: 20 }

  validates_uniqueness_of :username

  has_many :posts
  has_many :active_followings, class_name: 'Following',
                               foreign_key: 'follower_id',
                               dependent: :destroy
  has_many :passive_followings, class_name: 'Following',
                                foreign_key: 'followed_id',
                                dependent: :destroy
  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower

  mount_uploader :photo, FileUploader
  mount_uploader :coverimage, FileUploader

  scope :show, ->(number) { take(number) }

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def topc
    tops = "SELECT followed_id FROM followings
                    GROUP BY followed_id ORDER BY COUNT(followed_id) desc"
    User.where("id IN (#{tops})")
  end
end
