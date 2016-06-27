class User < ApplicationRecord
  has_many :posts
  has_secure_password
# does password hashing using bcrypt gem, and checks if passwords match

  validates :email, presence: true, uniqueness: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: ': Email is invalid'}
  validates :password, presence: true, length:{ minimum: 8 }
  # email is main point of identification, so must be unique
end
