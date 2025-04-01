class Comment < ApplicationRecord
  include ScopeToServer
  include Likeable
  belongs_to :member
  belongs_to :commentable, polymorphic: true, counter_cache: :comments_count

  has_rich_text :content
end
