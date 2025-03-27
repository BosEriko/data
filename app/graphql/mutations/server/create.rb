module Mutations
  module Server
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_server_attributes, Types::ServerAttributes::Create, required: true

      field :server, Types::ServerType, null: true
      field :errors, [String], null: true

      def resolve(create_server_attributes:)
        check_authentication!
        check_admin!

        server = ::Server.new(
          identifier: create_server_attributes[:identifier],
          creator_id: context[:current_user].id
        )

        if server.save
          server.members.create(
            email: context[:current_user].email,
            password_digest: context[:current_user].password_digest,
            user_id: context[:current_user].id
          )

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