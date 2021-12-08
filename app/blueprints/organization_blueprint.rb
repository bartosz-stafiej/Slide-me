# frozen_string_literal: true

class OrganizationBlueprint < Blueprinter::Base
  identifier :id

  fields :name,
         :created_at,
         :identifier,
         :updated_at
end
