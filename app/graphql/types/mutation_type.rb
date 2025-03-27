# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # User Mutations
    field :sign_up_user, mutation: Mutations::User::SignUp
    field :sign_in_user, mutation: Mutations::User::SignIn

    # Member Mutations
    field :sign_up_member, mutation: Mutations::Member::SignUp
    field :sign_in_member, mutation: Mutations::Member::SignIn
    field :update_member, mutation: Mutations::Member::Update

    # Post Mutations
    field :create_post, mutation: Mutations::Post::Create

    # Server Mutations
    field :create_server, mutation: Mutations::Server::Create
  end
end
