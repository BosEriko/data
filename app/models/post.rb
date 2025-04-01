class Post < ApplicationRecord
  include ScopeToServer
  include Likeable
  include Commentable
  belongs_to :member

  has_rich_text :description
end
