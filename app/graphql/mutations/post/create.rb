module Mutations
  module Post
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_post_attributes, Types::PostAttributes::Create, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(create_post_attributes:)
        check_authentication!

        server = if context[:current_user].role == "user"
          ::Server.find_by(public_key: create_post_attributes[:server_key])
        else
          context[:current_user].server
        end

        member_id = if context[:current_user].role == "user"
          ::Member.find_by(user_id: context[:current_user].id, server_id: server.id)&.id
        else
          context[:current_user].id
        end

        post = ::Post.new(
          title: create_post_attributes[:title],
          description: create_post_attributes[:description],
          member_id: member_id,
          server_id: server.id
        )

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