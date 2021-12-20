# frozen_string_literal: true

class Organization < ApplicationRecord
  has_one :address,
          as: :addressable,
          dependent: :destroy

  has_many :organization_memberships,
           inverse_of: :organization,
           dependent: :destroy

  has_many :users,
           through: :organization_memberships,
           inverse_of: :organizations,
           dependent: :nullify
end
