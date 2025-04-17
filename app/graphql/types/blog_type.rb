# frozen_string_literal: true

module Types
  class BlogType < Types::BaseObject
    field :id, ID, null: true
    field :title, String, null: true
    field :description, String, null: true
  end
end