module Mutations
  module Member
    class Update < ::Mutations::BaseMutation
      argument :update_member_attributes, Types::MemberAttributes::Update, required: true

      field :member, Types::MemberType, null: true
      field :errors, [String], null: true

      def resolve(update_member_attributes:)
        check_authentication!

        member = context[:current_user].role == "user" ? ::Member.find(update_member_attributes[:id]) : context[:current_user]

        if context[:current_user].role == "user" && !member.server.is_admin?(context[:current_user].id)
          raise GraphQL::ExecutionError, "You need to be an admin of the server where member is located."
        end

        member.first_name = update_member_attributes[:first_name]
        member.last_name = update_member_attributes[:last_name]
        member.age = update_member_attributes[:age]

        if member.save
          {
            member: member,
            errors: []
          }
        else
          {
            user: nil,
            errors: member.errors.full_messages
          }
        end
      end
    end
  end
end