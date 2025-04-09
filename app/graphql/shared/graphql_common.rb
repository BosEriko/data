# frozen_string_literal: true

module Shared
  module GraphqlCommon
    extend ActiveSupport::Concern

    included do
      # You can include shared `before` logic or helpers here if needed
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

    def check_server_admin!
      error_message = "You need to be an admin of this server to perform this action"
      check_condition!(context[:current_user].admin? && context[:current_server].is_admin?(context[:current_user].id), error_message)
    end

    def check_server_membership!
      check_condition!(current_member.server_id == context[:current_server].id, "You need to be a member of this server to perform this action")
    end

    def check_item_ownership!(item)
      error_message = "You need to be the owner of this #{item.class.name.downcase} to perform this action"
      check_condition!(context[:current_user].admin? ? context[:current_server].is_admin?(context[:current_user].id) : item.member_id == context[:current_user].id, error_message)
    end

    def check_item_scope!(item)
      check_condition!(item.server_id == context[:current_server].id, "The #{item.class.name.downcase} needs to be from this server")
    end

    private

    def check_condition!(condition, error_message)
      raise GraphQL::ExecutionError, error_message unless condition
    end
  end
end
