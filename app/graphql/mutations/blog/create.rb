module Mutations
  module Blog
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_blog_attributes, Types::BlogAttributes::Create, required: true

      field :blog, Types::BlogType, null: true
      field :errors, [String], null: true

      def resolve(create_blog_attributes:)
        check_authentication!
        check_server_membership!

        blog = ::Blog.new(
          title: create_blog_attributes[:title],
          description: create_blog_attributes[:description],
          member_id: current_member.id,
          server_id: context[:current_server].id
        )

        if blog.save
          {
            blog: blog,
            errors: []
          }
        else
          {
            blog: nil,
            errors: blog.errors.full_messages
          }
        end
      end
    end
  end
end