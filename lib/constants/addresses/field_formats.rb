# frozen_string_literal: true

module Constants
  module Addresses
    module FieldFormats
      CITY = /\A[a-zA-Z ']+\z/
      COUNTRY = /\A[a-zA-Z ']+\z/
      POST_CODE = /\A[A-Za-z0-9\-_`,. ]{3,12}\z/
    end
  end
end
