module Mutations
  module Post
    class Update < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "update.graphql"))

      argument :update_post_attributes, Types::PostAttributes::Update, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(update_post_attributes:)
        check_authentication!
        check_server_membership!

        post = ::Post.find(update_post_attributes[:id])
        check_item_scope!(post)

        post.title = update_post_attributes[:title]
        post.description = update_post_attributes[:description]

        if post.save
          {
            post: post,
            errors: []
          }
        else
          {
            post: nil,
            errors: post.errors.full_messages
          }
        end
      end
    end
  end
end