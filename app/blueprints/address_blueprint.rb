# frozen_string_literal: true

class AddressBlueprint < Blueprinter::Base
  identifier :id

  fields :post_code,
         :created_at,
         :updated_at,
         :city,
         :country,
         :address_line,
         :addressable_id,
         :addressable_type
end
