module Queries
  module Post
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the posts.'
      argument :server_key, String, required: true
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::PostType], null: false

      def resolve(limit: 20, offset: 0, server_key: null)
        check_authentication!
        check_admin!

        server = ::Server.find_by(public_key: server_key)

        posts = server.posts.order('created_at DESC')
        posts.offset(offset).limit(limit)
      end
    end
  end
end