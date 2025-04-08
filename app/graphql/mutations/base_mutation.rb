# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    # Fix for duplicate CreateInput error that stops the schema from being loaded
    # Issue Link: https://github.com/rmosolgo/graphql-ruby/issues/3919
    def self.default_graphql_name
      _mutations_namespace, object_name, action_name = self.name.split("::")
      "#{action_name}#{object_name}"
    end

    def current_member
      context[:current_user].admin? ? ::Member.find_by(user_id: context[:current_user].id, server_id: context[:current_server].id) : context[:current_user]
    end

    def check_authentication!
      check_condition!(context[:current_user], "You need to authenticate to perform this action")
    end

    def check_admin!
      check_condition!(context[:current_user].admin?, "You need to be an admin to perform this action")
    end

    def check_server_membership!
      check_condition!(current_member.server_id == context[:current_server].id, "You need to be a member of this server to perform this action")
    end

    def check_item_ownership!(item, name)
      error_message = "You need to be the owner of this #{name} to perform this action"
      if context[:current_user].admin?
        check_condition!(context[:current_server].is_admin?(context[:current_user].id), error_message)
      else
        check_condition!(item.member_id == context[:current_user].id, error_message)
      end
    end

    def check_item_scope!(item, name)
      check_condition!(item.server_id != context[:current_server].id, "The #{name} needs to be from this server")
    end

    def check_condition!(condition, error_message)
      raise GraphQL::ExecutionError, error_message unless condition
    end
  end
end
