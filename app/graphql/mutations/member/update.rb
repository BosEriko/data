module Mutations
  module Member
    class Update < ::Mutations::BaseMutation
      argument :update_member_attributes, Types::MemberAttributes::Update, required: true

      field :member, Types::MemberType, null: true
      field :errors, [String], null: true

      def resolve(update_member_attributes:)
        check_authentication!
        check_server_admin! if context[:current_user].admin?

        member = context[:current_user].admin? ? ::Member.find(update_member_attributes[:id]) : context[:current_user]

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
            member: nil,
            errors: member.errors.full_messages
          }
        end
      end
    end
  end
end