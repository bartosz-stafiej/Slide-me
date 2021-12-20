# frozen_string_literal: true

class OrganizationPolicy < ApplicationPolicy
  scope_for :active_record_relation, :member do |relation|
    ids = OrganizationMembership.where(user_id: user.id).pluck(:organization_id)
    relation.where(id: ids)
  end

  scope_for :active_record_relation, :inspector do |relation|
    next relation unless at_least_admin?

    relation
  end

  def index?
    at_least_admin?
  end

  def show?
    at_least_admin?
  end

  def update?
    at_least_admin? || at_least_organization_manager?
  end

  def destroy?
    owner?
  end
end
