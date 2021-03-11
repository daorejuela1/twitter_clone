class Follow < ApplicationRecord
  validates :follower, presence: true, uniqueness: { case_sensitive: false }
  validates :following, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :follower, foreign_key: 'user_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'

end
