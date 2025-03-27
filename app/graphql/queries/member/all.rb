module Queries
  module Member
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the members.'
      argument :server_key, String, required: true
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::MemberType], null: false

      def resolve(server_key:, limit: 20, offset: 0)
        check_authentication!

        server = ::Server.find_by(public_key: server_key)

        if (context[:current_user].role == "user" && !server.users.exists?(id: context[:current_user].id)) || (context[:current_user].role == "member" && !server.members.exists?(id: context[:current_user].id))
          raise GraphQL::ExecutionError, "You need to be part of this server to see the list of members."
        end

        members = server.members.order('created_at DESC')
        members.offset(offset).limit(limit)
      end
    end
  end
end
