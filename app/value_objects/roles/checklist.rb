# frozen_string_literal: true

require 'constants/roles/general'

module Roles
  Roles = Constants::Roles::General

  Checklist = Struct.new(:body) do
    delegate :[], to: :body

    def names
      body.keys
    end

    def has?(*role_names)
      role_names.all? { |r| body[r] }
    end

    def at_least_admin?
      has?(Roles::ADMIN)
    end

    def highest
      [Roles::SUPERADMIN, Roles::ADMIN, Roles::GUEST].find { |r| has?(r) }
    end

    def managed_role_names(hierarchy_context)
      Roles::HIERARCHIES.dig(hierarchy_context, highest) || []
    end
  end
end
