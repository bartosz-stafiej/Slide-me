# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    post_code { '32-231' }
    country { 'Poland' }
    city { 'Warsaw' }
    address_line { 'Drogowa 34/2' }
  end
end
