# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Server Query
    field :all_servers, resolver: Queries::Server::All

    # Post Query
    field :all_posts, resolver: Queries::Post::All

    # Blog Query
    field :all_blogs, resolver: Queries::Blog::All

    # Comment Query
    field :all_comments, resolver: Queries::Comment::All

    # Member Query
    field :all_members, resolver: Queries::Member::All
  end
end