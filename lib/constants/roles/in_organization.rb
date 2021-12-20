# frozen_string_literal: true

module Constants
  module Roles
    module InOrganization
      MANAGER = 'manager'
      OWNER = 'owner'
      MEMBER = 'member'

      DEFAULT = MEMBER

      HIERARCHIES = [
        OWNER,
        MANAGER,
        MEMBER
      ].freeze
    end
  end
end
