# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :email,
         :created_at,
         :updated_at

  association :address, blueprint: AddressBlueprint
  association :organizations, blueprint: OrganizationBlueprint
  association :roles, blueprint: RoleBlueprint
end
