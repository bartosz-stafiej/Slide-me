# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/organizations#show', type: :request do
  path '/api/v1/organizations/{id}' do
    get('Show organization') do
      tags 'Organizations'

      security [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer

      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let!(:admin_role) { create(:admin_role, user: admin) }

        let(:organization) { create(:organization) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }

        let(:id) { organization.id }

        schema '$ref': '#/components/schemas/organization_schema'

        before { sign_in(admin) }

        context 'when successful request' do
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
          end
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let(:organization) { create(:organization) }
          let(:Authorization) { 'Bearer token' }
          let(:user) { create(:user) }
          let(:input) { nil }
          let(:id) { organization.id }

          before { sign_in(user) }
        end
      end

      response(404, 'not found') do
        let!(:admin_role) { create(:admin_role, user: admin) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:id) { 0 }
        let(:search_param) { { id: id } }

        before { sign_in(admin) }

        include_examples 'not found response', klass: 'Organization'
      end
    end
  end

  path '/api/v1/users/me/organizations/{id}' do
    get('Show organization') do
      tags 'Organizations'

      security [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer

      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let!(:address) { create(:address, addressable: organization) }

        let(:organization) { create(:organization) }
        let(:user) { create(:user) }
        let(:Authorization) { 'Bearer token' }
        let(:id) { organization.id }

        schema '$ref': '#/components/schemas/organization_schema'

        before do
          OrganizationMembership.create(
            organization: organization,
            user: user
          )
          sign_in(user)
        end

        context 'when successfull resposne' do
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
            expect(json['organization']['address']['id']).to eq(address.id)
          end
        end
      end

      response(404, 'not found') do
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:id) { 0 }
        let(:search_param) { { id: id } }

        before { sign_in(admin) }

        include_examples 'not found response', klass: 'Organization'
      end
    end
  end
end
