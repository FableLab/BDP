class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name,  presence: true, length: { minium: 3, maximum: 30 }, uniqueness: true, format: { without: /\s/ }
  before_save { email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
end
