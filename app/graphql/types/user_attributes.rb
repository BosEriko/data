# frozen_string_literal: true

module Types
  class UserAttributes
    class SignUp < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end

    class SignIn < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
