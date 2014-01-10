class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true,  length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.?[a-z]+\.?[a-z]+\z\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
