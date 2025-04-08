# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Shared::GraphqlCommon
  end
end