module Queries
  # Base Queries class
  class BaseQuery < GraphQL::Schema::Resolver
    def check_authentication!
      check_condition!(context[:current_user] || context[:current_member], "You need to authenticate to perform this action")
    end

    def check_user_authentication!
      check_condition!(context[:current_user], "You need to authenticate to perform this action")
    end

    def check_member_authentication!
      check_condition!(context[:current_member], "You need to authenticate to perform this action")
    end

    def check_admin_privilege!
      # Check context[:current_user].id if passes Server.is_admin?()
    end

    def check_condition!(condition, error_message)
      raise GraphQL::ExecutionError, error_message unless condition
    end
  end
end