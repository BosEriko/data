module ScopeToServer
  extend ActiveSupport::Concern

  included do
    belongs_to :server
  end
end