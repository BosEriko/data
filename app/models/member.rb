class Member < ApplicationRecord
  belongs_to :user
  belongs_to :server

  enum membership_type: { user: 0, admin: 1 }

  validates :membership_type, presence: true
end

