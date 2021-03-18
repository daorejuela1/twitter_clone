class Follow < ApplicationRecord
  validates :follower, presence: true
  validates :following, presence: true
  validate :following_otheruser

  belongs_to :follower, foreign_key: 'user_id', class_name: 'User', primary_key: :username
  belongs_to :following, foreign_key: 'following_id', class_name: 'User', primary_key: :username

  def following_otheruser
    if (follower == following)
      errors.add(:follow, 'You can not follow yourself')
    end
  end
end
