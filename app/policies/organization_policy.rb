# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
