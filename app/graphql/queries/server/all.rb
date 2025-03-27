module Queries
  module Server
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the servers.'
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::ServerType], null: false

      def resolve(limit: 20, offset: 0)
        check_authentication!
        check_admin!

        servers = context[:current_user].servers.order('created_at DESC')
        servers.offset(offset).limit(limit)
      end
    end
  end
end