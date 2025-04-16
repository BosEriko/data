# frozen_string_literal: true

module Mutations
  module Member
    class SignUp < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "sign_up.graphql"))

      class MemberSignUpData < Types::BaseInputObject
        argument :credentials, Types::MemberAttributes::SignUp, required: false
      end

      argument :sign_up_data, MemberSignUpData, required: false

      type Types::MemberType

      def resolve(sign_up_data: nil)
        server_id = context[:current_server].id

        if context[:current_user]&.role == "user" && context[:current_user].server_ids.include?(server_id)
          ::PaperTrail.request.whodunnit = context[:current_user].id.to_s
        end

        email = sign_up_data&.dig(:credentials, :email)
        password = sign_up_data&.dig(:credentials, :password)

        unless email.present? && password.present?
          raise GraphQL::ExecutionError.new("Email and password must be provided.")
        end

        member = ::Member.new(email: email, password: password, server_id: server_id)

        if member.save
          member
        else
          raise GraphQL::ExecutionError.new(
            member.errors.full_messages.join(", "),
            extensions: { code: "MEMBER_SIGN_UP_FAILED", errors: member.errors.to_h }
          )
        end
      end
    end
  end
end
