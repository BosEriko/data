module IdentityMethods
  extend ActiveSupport::Concern

  def role
    self.class.name.downcase
  end
end