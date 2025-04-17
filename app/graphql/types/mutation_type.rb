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
    
    # Like Mutations
    field :create_like, mutation: Mutations::Like::Create

    # Post Mutations
    field :create_post, mutation: Mutations::Post::Create
    field :update_post, mutation: Mutations::Post::Update

    # Blog Mutations
    field :create_blog, mutation: Mutations::Blog::Create
    field :update_blog, mutation: Mutations::Blog::Update

    # Comment Mutations
    field :create_comment, mutation: Mutations::Comment::Create

    # Server Mutations
    field :create_server, mutation: Mutations::Server::Create
  end
end
