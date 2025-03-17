class Post < ApplicationRecord
  belongs_to :server
  belongs_to :member
end
