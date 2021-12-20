# frozen_string_literal: true

require 'constants/roles/in_organization'

module RolesInOrganization
  Roles = Constants::Roles::InOrganization

  Checklist = Struct.new(:body) do
    delegate :[], to: :body

    def names(organization_id)
      body[organization_id]&.keys || []
    end

    def has?(*role_names, org_id:)
      return body.key?(org_id) if role_names.empty?

      role_names.all? { |r| body.dig(org_id, r) }
    end

    def member?(organization_id)
      has?(Roles::MEMBER, org_id: organization_id)
    end

    def at_least_manager?(organization_id)
      [Roles::MANAGER, Roles::OWNER].any? { |r| has?(r, org_id: organization_id) }
    end

    def owner?(organization_id)
      has?(Roles::OWNER, org_id: organization_id)
    end

    def highest(organization_id)
      [Roles::OWNER, Roles::MANAGER, Roles::MEMBER].find { |r| has?(r, org_id: organization_id) }
    end

    def managed_role_names(hierarchy_context, org_id:)
      Roles::HIERARCHIES.dig(hierarchy_context, highest(org_id)) || []
    end
  end
end
