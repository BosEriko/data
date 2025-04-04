module Mutations
  module Like
    class Create < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "create.graphql"))

      argument :create_like_attributes, Types::LikeAttributes::Create, required: true

      field :like, Types::LikeType, null: true
      field :errors, [String], null: true

      def resolve(create_like_attributes:)
        check_authentication!

        server = if context[:current_user].role == "user"
          ::Server.find_by(public_key: create_like_attributes[:server_key])
        else
          context[:current_user].server
        end

        member_id = if context[:current_user].role == "user"
          ::Member.find_by(user_id: context[:current_user].id, server_id: server.id)&.id
        else
          context[:current_user].id
        end

        likeable_klass = create_like_attributes[:likeable_type].constantize
        likeable = likeable_klass.find(create_like_attributes[:likeable_id])

        raise GraphQL::ExecutionError, "You need to be a member of the server." unless server.members.exists?(id: member_id)
        raise GraphQL::ExecutionError, "You can only like on your server." unless likeable.server_id == server.id

        like = likeable.likes.new(
          member_id: member_id,
          server_id: server.id
        )

        if like.save
          {
            like: like,
            errors: []
          }
        else
          {
            like: nil,
            errors: like.errors.full_messages
          }
        end
      end
    end
  end
end