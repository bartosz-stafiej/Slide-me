# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@email.com' }
    password { 'password' }
  end

  factory :admin do
    email { 'admin@email.com' }
    password { 'admin_password' }
  end
end
