module Queries
  module Blog
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the blogs inside a server.'
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::BlogType], null: false

      def resolve(limit: 20, offset: 0)
        check_authentication!
        check_server_admin!

        blogs = context[:current_server].blogs.order('created_at DESC')
        blogs.offset(offset).limit(limit)
      end
    end
  end
end