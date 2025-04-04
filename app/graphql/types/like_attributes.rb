# frozen_string_literal: true

module Types
  class LikeAttributes
    class Create < BaseInputObject
      graphql_name "LikeCreate"

      argument :likeable_id, ID, required: true
      argument :likeable_type, String, required: true
      argument :server_key, String, required: false
    end
  end
end
