# frozen_string_literal: true

module Mutations
  module User
    class SignUp < ::Mutations::BaseMutation
      class SignUpData < Types::BaseInputObject
        argument :credentials, Types::UserAttributes::SignUp, required: false
      end
      
      argument :sign_up_data, SignUpData, required: false
      
      type Types::UserType
      
      def resolve(sign_up_data: nil)
        ::User.create!(
          email: sign_up_data&.[](:credentials)&.[](:email),
          password: sign_up_data&.[](:credentials)&.[](:password)
        )
      end
    end
  end
end