# frozen_string_literal: true

module Types
  class MemberType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :server_id, ID, null: false
  end
end
