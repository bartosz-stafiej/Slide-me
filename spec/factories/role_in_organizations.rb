# frozen_string_literal: true

FactoryBot.define do
  factory :role_in_organization do
    name { 'member' }

    factory :org_manager_role do
      name { 'manager' }
    end

    factory :org_owner_role do
      name { 'owner' }
    end
  end
end
