class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, uniqueness: true, length: { maximum: 30 }, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true, length: { maximum: 50 }

  has_many :terms

  has_secure_password
end
