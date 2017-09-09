class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, uniqueness: true, length: { maximum: 30 }
  validates :email, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }

  has_many :terms

  has_secure_password
end
