# frozen_string_literal: true

module Types
  class MemberAttributes
    class SignUp < BaseInputObject
      graphql_name "MemberSignUp"

      argument :email, String, required: true
      argument :password, String, required: true
      argument :server_key, String, required: true
    end

    class SignIn < BaseInputObject
      graphql_name "MemberSignIn"

      argument :email, String, required: true
      argument :password, String, required: true
      argument :server_key, String, required: true
    end

    class Update < BaseInputObject
      graphql_name "MemberUpdate"

      argument :id, ID, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :age, Integer, required: false
    end
  end
end
