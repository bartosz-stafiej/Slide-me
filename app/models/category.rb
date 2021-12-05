# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :creator,
             class_name: :Admin,
             inverse_of: :created_categories,
             optional: true
end
