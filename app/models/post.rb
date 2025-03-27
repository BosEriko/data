class Post < ApplicationRecord
  include ScopeToServer
  belongs_to :member
end
