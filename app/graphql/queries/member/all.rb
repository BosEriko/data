module Queries
  module Member
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the members.'
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::MemberType], null: false

      def resolve(limit: 20, offset: 0)
        check_authentication!
        check_server_membership!

        members = context[:current_server].members.order('created_at DESC')
        members.offset(offset).limit(limit)
      end
    end
  end
end
