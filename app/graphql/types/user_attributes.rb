# frozen_string_literal: true

module Types
  class UserAttributes
    class SignUp < BaseInputObject
      graphql_name "UserSignUp"

      argument :email, String, required: true
      argument :password, String, required: true
    end

    class SignIn < BaseInputObject
      graphql_name "UserSignIn"

      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
