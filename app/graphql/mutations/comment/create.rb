module Mutations
  module Comment
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_comment_attributes, Types::CommentAttributes::Create, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(create_comment_attributes:)
        check_authentication!
        check_server_membership!

        post = ::Post.find(create_comment_attributes[:post_id])
        check_item_scope!(post)

        comment = post.comments.new(
          content: create_comment_attributes[:content],
          member_id: current_member.id,
          server_id: context[:current_server].id
        )

        if comment.save
          {
            comment: comment,
            errors: []
          }
        else
          {
            comment: nil,
            errors: comment.errors.full_messages
          }
        end
      end
    end
  end
end