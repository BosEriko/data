module Queries
  module Comment
    class All < Queries::BaseQuery
      REQUEST_DEFINITION = File.read(File.join(__dir__, "all.graphql"))

      description 'Return all the comments of a post.'
      argument :post_id, ID, required: false
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
      type [Types::CommentType], null: false

      def resolve(post_id: nil, limit: 20, offset: 0)
        check_authentication!
        check_server_membership!

        post = ::Post.find(post_id)
        check_item_scope!(post)

        comments = post.comments.order('created_at DESC')
        comments.offset(offset).limit(limit)
      end
    end
  end
end