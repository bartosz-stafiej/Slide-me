# frozen_string_literal: true

class Organization < ApplicationRecord
  has_one :address,
          as: :addressable,
          dependent: :destroy

  has_many :organization_members,
           class_name: :User,
           inverse_of: :organization,
           dependent: :nullify
end
