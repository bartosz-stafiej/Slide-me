# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/organizations#index', type: :request do
  path '/api/v1/organizations' do
    get('Index all organizations') do
      tags 'Organizations'

      security [bearer_auth: []]

      consumes 'application/json'

      include_context 'pagination parameters'

      response(200, 'successful') do
        let!(:admin_role) { create(:admin_role, user: admin) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }

        schema '$ref': '#/components/schemas/organizations_schema'

        before { sign_in(admin) }

        context 'when some organizations' do
          let!(:organization) { create(:organization) }
          let(:example_schema) { { '$ref': '#/components/schemas/organizations_schema' } }

          run_test! do
            json = parse(response.body)
            expect(json['organizations'][0]['id']).to eq(organization.id)
          end
        end

        context 'when no organizations' do
          let(:example_schema) { { '$ref': '#/components/schemas/organizations_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organizations']).to be_empty
          end
        end
      end

      response(400, 'bad request') do
        include_examples 'invalid pagination parameter' do
          let!(:admin_role) { create(:admin_role, user: admin) }
          let(:admin) { create(:admin) }
          let(:items) { 'invaliditems' }
          let(:Authorization) { 'Bearer token' }

          before { sign_in(admin) }
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let(:user) { create(:user) }
          let(:Authorization) { 'Bearer token' }
          let(:input) { nil }

          before { sign_in(user) }
        end
      end
    end
  end

  path '/api/v1/users/me/organizations' do
    get('Index all user\'s organizations') do
      tags 'Organizations'

      security [bearer_auth: []]

      consumes 'application/json'

      include_context 'pagination parameters'

      response(200, 'successful') do
        let(:user) { create(:user) }
        let(:Authorization) { 'Bearer token' }

        schema '$ref': '#/components/schemas/organizations_schema'

        before { sign_in(user) }

        context 'when no organizations' do
          let(:example_schema) { { '$ref': '#/components/schemas/organizations_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organizations']).to be_empty
          end
        end

        context 'when some organizations' do
          let!(:organization) { create(:organization) }
          let(:example_schema) { { '$ref': '#/components/schemas/organizations_schema' } }

          before do
            OrganizationMembership.create(
              user: user,
              organization: organization
            )
          end

          run_test! do
            json = parse(response.body)
            expect(json['organizations'][0]['id']).to eq(organization.id)
          end
        end
      end

      response(400, 'bad request') do
        include_examples 'invalid pagination parameter' do
          let(:admin) { create(:admin) }
          let(:items) { 'invaliditems' }
          let(:Authorization) { 'Bearer token' }

          before { sign_in(admin) }
        end
      end
    end
  end
end
