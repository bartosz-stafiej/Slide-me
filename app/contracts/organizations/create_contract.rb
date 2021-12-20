# frozen_string_literal: true

module Organizations
  class CreateContract < ApplicationContract
    NAME_MAX_LENGTH = 100
    IDENTIFIER_FORMAT = /\A[0-9]{10}\z/

    config.messages.namespace = 'organizations.create'

    json do
      required(:name).filled(:string, max_size?: NAME_MAX_LENGTH)
      required(:address).hash(Addresses::Schemas::Create::JSON)

      optional(:identifier).filled(:string, format?: IDENTIFIER_FORMAT)
    end

    rule(:name) do
      key.failure(:taken) if Organization.exists?(name: value)
    end
  end
end
