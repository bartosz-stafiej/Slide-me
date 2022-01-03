# frozen_string_literal: true

class RoleBlueprint < Blueprinter::Base
  identifier :id

  fields :name,
         :user_id
end
