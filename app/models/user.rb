# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :created_categories,
           class_name: :Category,
           dependent: :nullify,
           foreign_key: :creator_id,
           inverse_of: :creator

  has_many :created_memberships,
           class_name: :OrganizationMembership,
           inverse_of: :created_by,
           dependent: :nullify

  has_many :created_roles,
           class_name: :Role,
           inverse_of: :created_by,
           foreign_key: :created_by_id,
           dependent: :nullify

  has_many :roles_in_organization_created,
           class_name: :RoleInOrganization,
           inverse_of: :added_by,
           foreign_key: :added_by_id,
           dependent: :nullify

  has_many :organization_memberships,
           inverse_of: :user,
           dependent: :destroy

  has_many :organizations,
           through: :organization_memberships,
           inverse_of: :users,
           dependent: :nullify

  has_many :roles,
           inverse_of: :user,
           dependent: :destroy
end
