class ContactRequest < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :subject, :body, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
