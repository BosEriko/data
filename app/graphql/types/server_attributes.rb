# frozen_string_literal: true

module Types
  class ServerAttributes
    class Create < BaseInputObject
      graphql_name "ServerCreate"

      argument :identifier, String, required: true
    end
  end
end
