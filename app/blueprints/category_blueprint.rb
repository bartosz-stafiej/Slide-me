# frozen_string_literal: true

class CategoryBlueprint < Blueprinter::Base
  identifier :id

  fields :name,
         :created_at,
         :creator_id,
         :updated_at
end
