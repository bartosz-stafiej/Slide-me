# frozen_string_literal: true

module Categories
  class UpdateContract < ApplicationContract
    NAME_MAX_LENGTH = 100

    config.messages.namespace = 'categories.update'

    json do
      optional(:name).filled(:string, max_size?: NAME_MAX_LENGTH)
    end

    rule(:name) do
      key.failure(:taken) if Category.exists?(name: value)
    end
  end
end
