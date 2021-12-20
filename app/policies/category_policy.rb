# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def create?
    at_least_admin?
  end

  def update?
    at_least_admin?
  end

  def destroy?
    at_least_admin?
  end
end
