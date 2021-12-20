# frozen_string_literal: true

module ParseRolesHelper
  def roles(user)
    Role.checklist(user).body.keys
  end

  def org_roles(user:, org_id:)
    RoleInOrganization
      .checklist(user)
      .body[org_id]&.keys
  end
end

RSpec.configure do |config|
  config.include ParseRolesHelper, type: :request
end
