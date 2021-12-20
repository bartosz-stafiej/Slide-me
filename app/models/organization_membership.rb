# frozen_string_literal: true

class OrganizationMembership < ApplicationRecord
  belongs_to :created_by,
             class_name: :User,
             optional: true

  belongs_to :organization,
             inverse_of: :organization_memberships

  belongs_to :user,
             inverse_of: :organization_memberships

  has_many :roles_in_organization,
           inverse_of: :organization_membership,
           class_name: :RoleInOrganization,
           dependent: :destroy
end
