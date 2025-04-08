# frozen_string_literal: true

module Types
  class MemberType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :age, Integer, null: true
  end
end
