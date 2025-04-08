# frozen_string_literal: true

module Types
  class PostAttributes
    class Create < BaseInputObject
      graphql_name "PostCreate"

      argument :title, String, required: true
      argument :description, String, required: true
    end

    class Update < BaseInputObject
      graphql_name "PostUpdate"

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
    end
  end
end
