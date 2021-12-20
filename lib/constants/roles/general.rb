# frozen_string_literal: true

module Constants
  module Roles
    module General
      ADMIN = 'admin'
      GUEST = 'guest'
      USER = 'user'

      DEFAULT = GUEST

      HIERARCHIES = [
        ADMIN,
        USER,
        GUEST
      ].freeze
    end
  end
end
