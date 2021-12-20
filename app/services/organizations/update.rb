# frozen_string_literal: true

module Organizations
  class Update
    def call(data:, organization:)
      organization = update_organization(data, organization)
      Services::Result.new(output: organization)
    end

    private

    def update_organization(data, organization)
      organization.update(data.except(*virtuals))
      organization.address.update(data[:address]) if data[:address]

      organization
    end

    def virtuals
      Organizations::UpdateContract::VIRTUALS
    end
  end
end
