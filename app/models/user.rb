class User < ApplicationRecord
  has_secure_password

  has_many :members
  has_many :servers, through: :members

  has_many :created_servers, foreign_key: "creator_id", class_name: "Server"

  validates :email, presence: true, uniqueness: true
end
