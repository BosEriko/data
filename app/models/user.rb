class User < ApplicationRecord
  has_secure_password

  has_many :members
  has_many :servers, through: :members

  validates :email, presence: true, uniqueness: true
end
