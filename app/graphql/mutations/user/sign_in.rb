# frozen_string_literal: true

module Mutations
  module User
    class SignIn < ::Mutations::BaseMutation
      REQUEST_DEFINITION = File.read(File.join(__dir__, "sign_in.graphql"))

      null true

      argument :credentials, Types::UserAttributes::SignIn, required: false

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(credentials: nil)
        return unless credentials

        user = ::User.find_by email: credentials[:email]

        return unless user
        return unless user.authenticate(credentials[:password])

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")

        { user: user, token: token }
      end
    end
  end
end
