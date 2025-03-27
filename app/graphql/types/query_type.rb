# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Server Query
    field :servers, resolver: Queries::Server::All

    # Post Query
    field :posts, resolver: Queries::Post::All
  end
end