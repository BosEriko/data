module Mutations
  module Server
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :server_attributes, Types::ServerAttributes::Create, required: true

      field :server, Types::ServerType, null: true
      field :errors, [String], null: true

      def resolve(server_attributes:)
        check_user_authentication!
        server = ::Server.new(
          identifier: server_attributes[:identifier],
          creator_id: context[:current_user].id
        )

        if server.save
          {
            server: server,
            errors: []
          }
        else
          {
            server: nil,
            errors: server.errors.full_messages
          }
        end
      end
    end
  end
end