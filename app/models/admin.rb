# frozen_string_literal: true

class Admin < User
  has_many :created_categories,
           class_name: :Category,
           dependent: :nullify,
           foreign_key: :creator_id,
           inverse_of: :creator
end
