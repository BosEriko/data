class Member < ApplicationRecord
  has_paper_trail
  include ScopeToServer
  include IdentityMethods
  has_secure_password

  belongs_to :user, optional: true

  has_many :posts, dependent: :destroy
  has_many :blogs, dependent: :destroy

  validates :email, presence: true, uniqueness: { scope: :server_id, message: "should be unique within a server" }

  before_save :nullify_invalid_user

  def registered_by
    user_id = versions.first&.whodunnit
    User.find_by(id: user_id) || nil
  end

  def is_registered_by_an_admin?
    registered_by&.id != nil
  end

  private

  def nullify_invalid_user
    self.user_id = nil if user_id.present? && user.nil?
  end
end
