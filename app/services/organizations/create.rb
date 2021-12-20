# frozen_string_literal: true

require 'constants/roles/in_organization'

module Organizations
  class Create
    OWNER = Constants::Roles::InOrganization::OWNER

    def call(data:, owner:)
      organization = create_organization(data, owner)
      Services::Result.new(output: organization)
    end

    private

    delegate :transaction, to: :ApplicationRecord, private: true

    def create_organization(data, owner)
      transaction do
        organization = Organization.create(data.except(:address))
        Address.create(
          addressable: organization,
          **data[:address]
        )

        create_roles_in_organization(organization, owner)

        organization
      end
    end

    def create_roles_in_organization(organization, owner)
      org_membership = OrganizationMembership.create(
        organization: organization,
        user: owner
      )
      RoleInOrganization.create(
        name: OWNER,
        organization_membership: org_membership
      )
    end
  end
end
