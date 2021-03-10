class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]*\z/.freeze

  before_create :set_default_image
  before_create :correct_file_mime_type
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_USERNAME_REGEX }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_email_layers

  has_many :tweets, dependent: :destroy

  private
  def set_default_image
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), 
                      filename: 'default-image.png', content_type: 'image/png')
  end
  # Virtual attribute login - can be username or email
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

  def correct_file_mime_type
    if avatar.attached? && !avatar.image?
      avatar.purge if avatar.persisted?
      errors.add(:avatar, 'Image must be a JPG or PNG file')
    end
  end

  public

  def login
    @login || self.username || self.email
  end
  # Uses Truemail Gem to check if the email really exist
end

