# frozen_string_literal: true

module Types
  class BlogAttributes
    class Create < BaseInputObject
      graphql_name "BlogCreate"

      argument :title, String, required: true
      argument :description, String, required: true
    end

    class Update < BaseInputObject
      graphql_name "BlogUpdate"

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
    end
  end
end
