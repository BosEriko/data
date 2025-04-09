module IdentityMethods
  extend ActiveSupport::Concern

  def role
    self.class.name.downcase
  end

  def admin?
    is_a?(User)
  end

  def member?
    is_a?(Member)
  end
end