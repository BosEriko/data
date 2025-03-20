class Server < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  has_many :posts, dependent: :destroy

  before_create :generate_keys

  validates :identifier, presence: true, uniqueness: true

  private

  def generate_keys
    self.public_key = SecureRandom.hex(32)
    self.private_key = SecureRandom.hex(32)
  end
end

