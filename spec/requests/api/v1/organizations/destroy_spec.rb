# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/organizations#destroy', type: :request do
  path '/api/v1/organizations/{id}' do
    delete('Destroy an organizations') do
      tags 'Organizations'

      security [bearer_auth: []]

      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      response(204, 'successful') do
        let!(:owner_role) { create(:org_owner_role, organization_membership: org_membership) }
        let(:org_membership) { OrganizationMembership.create(user: owner, organization: organization) }
        let(:owner) { create(:user) }
        let(:Authorization) { 'Bearer token' }
        let(:organization) { create(:organization) }
        let(:id) { organization.id }

        before { sign_in(owner) }

        context 'when successful request' do
          run_test!
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let(:user) { create(:user) }
          let(:Authorization) { 'Bearer token' }
          let(:organization) { create(:organization) }
          let(:id) { organization.id }

          before { sign_in(user) }
        end
      end

      response(404, 'not_found') do
        let!(:admin_role) { create(:admin_role, user: admin) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:input) { nil }
        let(:id) { 0 }
        let(:search_param) { { id: id } }
        before { sign_in(admin) }

        include_examples 'not found response', klass: 'Organization'
      end
    end
  end
end
