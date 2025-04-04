# frozen_string_literal: true

module Types
  class PostAttributes
    class Create < BaseInputObject
      graphql_name "PostCreate"

      argument :title, String, required: true
      argument :description, String, required: true
      argument :server_key, String, required: false
    end
  end
end
