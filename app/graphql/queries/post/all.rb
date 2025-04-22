module Queries
  module Post
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the posts inside a server.'
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::PostType], null: false

      def resolve(limit: 20, offset: 0)
        check_authentication!

        posts = context[:current_server].posts.order('created_at DESC')
        posts.offset(offset).limit(limit)
      end
    end
  end
end
