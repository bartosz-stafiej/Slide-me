# frozen_string_literal: true

require 'constants/addresses/field_formats'
require 'constants/addresses/field_max_lengths'

module Addresses
  module Schemas
    module Create
      FieldMaxLengths = Constants::Addresses::FieldMaxLengths
      FieldFormats = Constants::Addresses::FieldFormats

      JSON = Dry::Schema.JSON do
        required(:address_line).filled(:string, max_size?: FieldMaxLengths::ADDRESS_LINE)
        required(:city).filled(:string, max_size?: FieldMaxLengths::CITY, format?: FieldFormats::CITY)
        required(:country).filled(:string, format?: FieldFormats::COUNTRY, max_size?: FieldMaxLengths::COUNTRY)
        required(:post_code).filled(:string, format?: FieldFormats::POST_CODE)
      end
    end
  end
end
