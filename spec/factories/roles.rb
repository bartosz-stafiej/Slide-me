# frozen_string_literal: true

require 'constants/roles/general'

FactoryBot.define do
  factory :role do
    name { Constants::Roles::General::GUEST }

    factory :admin_role do
      name { Constants::Roles::General::ADMIN }
    end

    factory :user_role do
      name { Constants::Roles::General::USER }
    end
  end
end
