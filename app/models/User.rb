class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6, maximum: 32 }, if: -> { new_record? || crypted_password_changed? }
  validates :password, confirmation: true, if: -> { new_record? || crypted_password_changed? }
  validates :password_confirmation, presence: true, if: -> { new_record? || crypted_password_changed? }

  validates :name,  presence: true, length: { minium: 3, maximum: 32 }, uniqueness: true, format: { without: /\s/ }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
end
