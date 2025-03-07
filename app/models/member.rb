class Member < ApplicationRecord
  belongs_to :user
  belongs_to :server

  enum :membership, { user: "user", admin: "admin" }

  validates :membership, presence: true
end
