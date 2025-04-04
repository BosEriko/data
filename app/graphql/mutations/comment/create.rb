module Mutations
  module Comment
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_comment_attributes, Types::CommentAttributes::Create, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(create_comment_attributes:)
        check_authentication!

        server = if context[:current_user].role == "user"
          ::Server.find_by(public_key: create_comment_attributes[:server_key])
        else
          context[:current_user].server
        end

        member_id = if context[:current_user].role == "user"
          ::Member.find_by(user_id: context[:current_user].id, server_id: server.id)&.id
        else
          context[:current_user].id
        end

        post = ::Post.find(create_comment_attributes[:post_id])

        raise GraphQL::ExecutionError, "You need to be a member of the server." unless server.members.exists?(id: member_id)
        raise GraphQL::ExecutionError, "You can only comment on posts on your server." unless post.server_id == server.id

        comment = post.comments.new(
          content: create_comment_attributes[:content],
          member_id: member_id,
          server_id: server.id
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