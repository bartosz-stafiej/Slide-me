# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < BaseController
      include Pagy::Backend

      def index
        authorize! Organization unless me?

        reader_kind = me? ? :member : :inspector

        scope = authorized_scope(Organization.all, as: reader_kind)

        @pagy, organizations = pagy(scope, items: params[:items])

        render json: OrganizationBlueprint.render(organizations, root: :organizations)
      end

      def show
        authorize! Organization unless me?

        reader_kind = me? ? :member : :inspector

        scope = authorized_scope(Organization.all, as: reader_kind)
        organization = scope.find(params[:id])

        render json: OrganizationBlueprint.render(organization, root: :organization)
      end

      def create
        contract = Organizations::CreateContract.new
        validation_results = validate!(contract)

        creator = Organizations::Create.new
        result = creator.call(data: validation_results.to_h,
                              owner: current_user)

        render json: OrganizationBlueprint.render(result.output, root: :organization),
               status: :created
      end

      def update
        reader_kind = me? ? :member : :inspector
        scope = authorized_scope(Organization.all, as: reader_kind)

        @organization = scope.find(params[:id])
        authorize! Organization

        contract = Organizations::UpdateContract.new
        validation_results = validate!(contract)

        updator = Organizations::Update.new
        result = updator.call(data: validation_results.to_h,
                              organization: @organization)

        render json: OrganizationBlueprint.render(result.output, root: :organization)
      end

      def destroy
        @organization = Organization.find(params[:id])

        authorize! Organization
        @organization.destroy

        head :no_content
      end
    end
  end
end
