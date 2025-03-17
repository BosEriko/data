class Member < ApplicationRecord
  has_secure_password

  belongs_to :user, optional: true
  belongs_to :server

  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: { scope: :server_id, message: "should be unique within a server" }

  before_save :nullify_invalid_user

  def admin?
    user_id.present?
  end

  private

  def nullify_invalid_user
    self.user_id = nil if user_id.present? && user.nil?
  end
end
