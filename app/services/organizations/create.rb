# frozen_string_literal: true

module Organizations
  class Create
    def call(data:)
      organization = Organization.create(data)
      Services::Result.new(output: organization)
    end
  end
end
