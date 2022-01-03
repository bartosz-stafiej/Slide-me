# frozen_string_literal: true

class MeBlueprint < Blueprinter::Base
  # association :user, blueprint: UserBlueprint

  association :address, blueprint: AddressBlueprint
  association :organizations, blueprint: OrganizationBlueprint
  association :roles, blueprint: RoleBlueprint
end
