# frozen_string_literal: true

require 'constants/sql/literals'

class RoleInOrganization < ApplicationRecord
  SQL_TRUE = Constants::SQL::Literals::TRUE

  belongs_to :organization_membership,
             inverse_of: :roles_in_organization

  belongs_to :added_by,
             class_name: :User,
             inverse_of: :roles_in_organization_created,
             optional: true

  def self.checklist(user)
    body = OrganizationMembership
           .where(user_id: user.id).each_with_object({}) do |org_membership, roles|
      roles[org_membership.organization_id] =
        Hash[*org_membership.roles_in_organization.pluck(:name, SQL_TRUE).flatten]
    end

    RolesInOrganization::Checklist.new(body)
  end
end
