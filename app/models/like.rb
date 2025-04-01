class Like < ApplicationRecord
  include ScopeToServer
  belongs_to :member
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count
end
