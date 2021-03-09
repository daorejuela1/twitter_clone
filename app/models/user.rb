class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]*\z/.freeze

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_USERNAME_REGEX }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_email_layers
  # Virtual attribute login - can be username or email
  def login
    @login || self.username || self.email
  end
  # Uses Truemail Gem to check if the email really exist
  def validate_email_layers
    errors.add(:email, 'Was not found') if !Truemail.valid?(email)
  end
  #overrrides find_first_by_auth_conditions to allow email or password as input
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", 
                               { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
