# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < BaseController
      def create
        authorize! Organization

        contract = Organizations::CreateContract.new
        validation_results = validate!(contract)

        creator = Organizations::Create.new
        result = creator.call(data: validation_results.to_h)

        render json: OrganizationBlueprint.render(result.output, root: :organization),
               status: :created
      end
    end
  end
end
