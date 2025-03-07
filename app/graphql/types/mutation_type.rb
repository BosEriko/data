# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # User Mutations
    field :sign_up_user, mutation: Mutations::User::SignUp
    field :sign_in_user, mutation: Mutations::User::SignIn
  end
end 