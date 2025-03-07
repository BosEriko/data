class User < ApplicationRecord
  has_secure_password

  has_many :members
  has_many :servers, through: :members

  has_many :admin_memberships, -> { where(membership_type: 'admin') }, class_name: 'Member'
  has_many :administered_servers, through: :admin_memberships, source: :server

  has_many :user_memberships, -> { where(membership_type: 'user') }, class_name: 'Member'
  has_many :joined_servers, through: :user_memberships, source: :server

  validates :email, presence: true, uniqueness: true
end
