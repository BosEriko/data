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
        if context[:current_user] && context[:current_user].role == "user" && context[:current_user].server_ids.include?(server_id)
          ::PaperTrail.request.whodunnit = context[:current_user]&.id.to_s
        end
        ::Member.create!(
          email: sign_up_data&.[](:credentials)&.[](:email),
          password: sign_up_data&.[](:credentials)&.[](:password),
          server_id: server_id
        )
      end
    end
  end
end
