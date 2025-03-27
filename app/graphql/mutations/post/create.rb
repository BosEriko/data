module Mutations
  module Post
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_post_attributes, Types::PostAttributes::Create, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(create_post_attributes:)
        check_member_authentication!
        post = ::Post.new(
          title: create_post_attributes[:title],
          content: create_post_attributes[:content],
          member_id: context[:current_member].id,
          server_id: context[:current_member].server_id
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