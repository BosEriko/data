# frozen_string_literal: true

module Mutations
  module User
    class SignUp < ::Mutations::BaseMutation
      class AuthProviderSignupData < Types::BaseInputObject
        argument :credentials, Types::UserAttributes, required: false
      end
      
      argument :auth_provider, AuthProviderSignupData, required: false
      
      type Types::UserType
      
      def resolve(auth_provider: nil)
        User.create!(
          email: auth_provider&.[](:credentials)&.[](:email),
          password: auth_provider&.[](:credentials)&.[](:password)
        )
      end
    end
  end
end