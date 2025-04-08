module IdentityMethods
  extend ActiveSupport::Concern

  def role
    self.class.name.downcase
  end

  def admin?
    self.class.name.downcase == "user"
  end

  def member?
    self.class.name.downcase == "member"
  end
end