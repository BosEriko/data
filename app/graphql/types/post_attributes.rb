# frozen_string_literal: true

module Types
  class PostAttributes
    class Create < BaseInputObject
      graphql_name "PostCreate"

      argument :title, String, required: true
      argument :content, String, required: true
    end
  end
end
