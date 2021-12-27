# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :creator,
             class_name: :User,
             inverse_of: :created_categories,
             optional: true
end
