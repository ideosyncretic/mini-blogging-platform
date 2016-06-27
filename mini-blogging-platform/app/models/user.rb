class User < ApplicationRecord
  has_many :posts
  has_secure_password
# does password hashing using bcrypt gem, and checks if passwords match

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length:{ minimum: 8 }, on: :create
  # email is main point of identification, so must be unique
end
