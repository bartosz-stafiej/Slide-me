# frozen_string_literal: true

require 'constants/roles/in_organization'

class ApplicationPolicy < ActionPolicy::Base
  authorize :user
  authorize :organization, optional: true

  delegate :at_least_admin?, to: :checklist

  def owner?
    return false if organization.nil?

    org_checklist.owner?(organization.id)
  end

  def at_least_organization_manager?
    return false if organization.nil?

    org_checklist.at_least_manager?(organization.id)
  end

  def organization_member?
    return false if organization.nil?

    org_checklist.member?(organization.id)
  end

  def checklist
    @checklist ||= Role.checklist(user)
  end

  def org_checklist
    @org_checklist ||= RoleInOrganization.checklist(user)
  end
end
