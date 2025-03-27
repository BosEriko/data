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
  end
end