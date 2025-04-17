module Mutations
  module Blog
    class Update < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "update.graphql"))

      argument :update_blog_attributes, Types::BlogAttributes::Update, required: true

      field :blog, Types::BlogType, null: true
      field :errors, [String], null: true

      def resolve(update_blog_attributes:)
        check_authentication!
        check_server_membership!

        blog = ::Blog.find(update_blog_attributes[:id])
        check_item_scope!(blog)

        blog.title = update_blog_attributes[:title]
        blog.description = update_blog_attributes[:description]

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