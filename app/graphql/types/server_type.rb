# frozen_string_literal: true

module Types
  class ServerType < Types::BaseObject
    field :id, ID, null: true
    field :identifier, String, null: true
    field :public_key, String, null: true
  end
end