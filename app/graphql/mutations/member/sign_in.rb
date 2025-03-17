# frozen_string_literal: true

module Mutations
  module Member
    class SignIn < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "sign_in.graphql"))

      null true

      argument :credentials, Types::MemberAttributes::SignIn, required: false

      field :token, String, null: true
      field :member, Types::MemberType, null: true

      def resolve(credentials: nil)
        return unless credentials

        member = ::Member.find_by email: credentials[:email], server_id: Server.find_by(public_key: credentials[:server_key]).id

        return unless member
        return unless member.authenticate(credentials[:password])

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("member-id:#{ member.id }")

        { member: member, token: token }
      end
    end
  end
end
