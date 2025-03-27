class Member < ApplicationRecord
  include ScopeToServer
  has_secure_password

  belongs_to :user, optional: true

  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: { scope: :server_id, message: "should be unique within a server" }

  before_save :nullify_invalid_user

  def role
    self.class.name.downcase
  end

  def admin?
    user_id.present?
  end

  private

  def nullify_invalid_user
    self.user_id = nil if user_id.present? && user.nil?
  end
end
