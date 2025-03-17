class Member < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :server
end
