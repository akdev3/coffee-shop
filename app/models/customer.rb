class Customer < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :orders

  validates :email, presence: true, length: { maximum: 50 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true
  validates :name, presence: true
end
