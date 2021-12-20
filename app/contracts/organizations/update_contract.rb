# frozen_string_literal: true

module Organizations
  class UpdateContract < ApplicationContract
    VIRTUALS = %i[address].freeze
    NAME_MAX_LENGTH = 100
    IDENTIFIER_FORMAT = /\A[0-9]{10}\z/

    config.messages.namespace = 'organizations.update'

    json do
      optional(:name).filled(:string, max_size?: NAME_MAX_LENGTH)
      optional(:address).hash(Addresses::Schemas::Create::JSON)

      optional(:identifier).filled(:string, format?: IDENTIFIER_FORMAT)
    end

    rule(:name) do
      key.failure(:taken) if Organization.exists?(name: value)
    end
  end
end
