module Queries
  # Base Queries class
  class BaseQuery < GraphQL::Schema::Resolver
    def check_authentication!
      check_condition!(context[:current_user], "You need to authenticate to perform this action")
    end

    def check_admin!
      check_condition!(context[:current_user].role == "user", "You need to be an admin to perform this action")
    end

    def check_condition!(condition, error_message)
      raise GraphQL::ExecutionError, error_message unless condition
    end
  end
end