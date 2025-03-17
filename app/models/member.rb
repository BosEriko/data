class Member < ApplicationRecord
  has_secure_password

  belongs_to :user, optional: true
  belongs_to :server

  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: { scope: :server_id, message: "should be unique within a server" }

  def admin?
    user_id.present?
  end
end
