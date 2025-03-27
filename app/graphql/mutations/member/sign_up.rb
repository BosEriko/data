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
        ::Member.create!(
          email: sign_up_data&.[](:credentials)&.[](:email),
          password: sign_up_data&.[](:credentials)&.[](:password),
          server_id: ::Server.find_by(public_key: sign_up_data&.[](:credentials)&.[](:server_key)).id
        )
      end
    end
  end
end
