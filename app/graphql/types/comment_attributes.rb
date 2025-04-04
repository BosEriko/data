# frozen_string_literal: true

module Types
  class CommentAttributes
    class Create < BaseInputObject
      graphql_name "CommentCreate"

      argument :content, String, required: true
      argument :server_key, String, required: false
      argument :post_id, ID, required: true
    end
  end
end
