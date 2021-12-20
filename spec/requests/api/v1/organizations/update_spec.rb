# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/organizations#update', type: :request do
  path '/api/v1/users/me/organizations/{id}' do
    put('Update organization') do
      tags 'Organizations'

      security [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer
      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  properties: {
                    name: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Organizations::CreateContract::NAME_MAX_LENGTH
                    },
                    identifier: {
                      type: 'string',
                      format: Organizations::CreateContract::IDENTIFIER_FORMAT
                    },
                    address: {
                      type: 'object',
                      properties: {
                        post_code: {
                          type: 'string',
                          minLength: 1,
                          format: Constants::Addresses::FieldFormats::POST_CODE
                        },
                        city: {
                          type: 'string',
                          minLength: 1,
                          maxLength: Constants::Addresses::FieldMaxLengths::CITY,
                          format: Constants::Addresses::FieldFormats::CITY
                        },
                        country: {
                          type: 'string',
                          minLength: 1,
                          format: Constants::Addresses::FieldFormats::COUNTRY,
                          maxLength: Constants::Addresses::FieldMaxLengths::COUNTRY
                        },
                        address_line: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }

      consumes 'application/json'
      produces 'application/json'

      response(200, 'successfull') do
        let!(:address) { create(:address, addressable: organization) }
        let!(:org_manager_role) { create(:org_manager_role, organization_membership: organization_membership) }

        let(:organization_membership) do
          OrganizationMembership.create(user: org_manager, organization: organization)
        end
        let(:organization) { create(:organization) }
        let(:org_manager) { create(:user) }

        let(:Authorization) { 'Bearer token' }
        let(:id) { organization.id }

        let(:valid_input) do
          attributes_for(:organization).merge(address: attributes_for(:address))
        end

        schema '$ref': '#/components/schemas/organization_schema'

        before { sign_in(org_manager) }

        context 'when not updating address' do
          let(:input) { { name: 'New title' } }
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
            expect(json['organization']['name']).to eq(input[:name])
            expect(json['organization']['address']['address_line']).to eq(address.address_line)
          end
        end

        context 'when updating address' do
          let(:input) { valid_input.slice(:address).merge(name: 'New title2') }
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
            expect(json['organization']['name']).to eq(input[:name])
            expect(json['organization']['address']['address_line']).to eq(input[:address][:address_line])
          end
        end
      end

      response(422, 'validation failed') do
        let!(:address) { create(:address, addressable: organization) }
        let!(:org_manager_role) { create(:org_manager_role, organization_membership: organization_membership) }

        let(:organization_membership) do
          OrganizationMembership.create(user: org_manger, organization: organization)
        end
        let(:organization) { create(:organization) }
        let(:org_manger) { create(:user) }

        let(:Authorization) { 'Bearer token' }
        let(:id) { organization.id }

        let(:valid_input) do
          attributes_for(:organization).merge(address: attributes_for(:address))
        end

        before { sign_in(org_manger) }

        it_behaves_like 'invalid field', description: 'when identifier invalid format' do
          let(:key) { [:identifier] }
          let(:value) { 'wrong identifier' }
          let(:key_message) { 'is in invalid format' }
        end

        it_behaves_like 'invalid field', description: 'when address invalid post_code format' do
          let(:key) { %i[address post_code] }
          let(:value) { '12sa1!213@' }
          let(:key_message) { 'is in invalid format' }
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let!(:member) { create(:role_in_organization, organization_membership: org_membership) }
          let(:org_membership) { OrganizationMembership.create(user: user, organization: organization) }
          let(:user) { create(:user) }
          let(:Authorization) { 'Bearer token' }
          let(:input) { nil }
          let(:organization) { create(:organization) }
          let(:id) { organization.id }

          before { sign_in(user) }
        end
      end

      response(404, 'not found') do
        let!(:org_manager_role) { create(:org_manager_role, organization_membership: organization_membership) }

        let(:organization_membership) do
          OrganizationMembership.create(user: org_manager, organization: organization)
        end
        let(:organization) { create(:organization) }
        let(:org_manager) { create(:user) }
        let(:Authorization) { 'Bearer token' }
        let(:id) { 0 }
        let(:input) { nil }
        let(:search_param) { { id: id } }

        before { sign_in(org_manager) }

        include_examples 'not found response', klass: 'Organization'
      end
    end
  end

  path '/api/v1/organizations/{id}' do
    put('Update organization') do
      tags 'Organizations'

      security [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer
      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  properties: {
                    name: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Organizations::CreateContract::NAME_MAX_LENGTH
                    },
                    identifier: {
                      type: 'string',
                      format: Organizations::CreateContract::IDENTIFIER_FORMAT
                    },
                    address: {
                      type: 'object',
                      properties: {
                        post_code: {
                          type: 'string',
                          minLength: 1,
                          format: Constants::Addresses::FieldFormats::POST_CODE
                        },
                        city: {
                          type: 'string',
                          minLength: 1,
                          maxLength: Constants::Addresses::FieldMaxLengths::CITY,
                          format: Constants::Addresses::FieldFormats::CITY
                        },
                        country: {
                          type: 'string',
                          minLength: 1,
                          format: Constants::Addresses::FieldFormats::COUNTRY,
                          maxLength: Constants::Addresses::FieldMaxLengths::COUNTRY
                        },
                        address_line: {
                          type: 'string'
                        }
                      }
                    }
                  }
                }

      consumes 'application/json'
      produces 'application/json'

      response(200, 'successfull') do
        let!(:address) { create(:address, addressable: organization) }
        let!(:admin_role) { create(:admin_role, user: admin) }

        let(:organization) { create(:organization) }
        let(:admin) { create(:admin) }

        let(:Authorization) { 'Bearer token' }
        let(:id) { organization.id }

        let(:valid_input) do
          attributes_for(:organization).merge(address: attributes_for(:address))
        end

        schema '$ref': '#/components/schemas/organization_schema'

        before { sign_in(admin) }

        context 'when not updating address' do
          let(:input) { { name: 'New title2' } }
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
            expect(json['organization']['name']).to eq(input[:name])
            expect(json['organization']['address']['address_line']).to eq(address.address_line)
          end
        end

        context 'when updating address' do
          let(:input) { valid_input.slice(:address).merge(name: 'New title2') }
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).to eq(organization.id)
            expect(json['organization']['name']).to eq(input[:name])
            expect(json['organization']['address']['address_line']).to eq(input[:address][:address_line])
          end
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let(:user) { create(:user) }
          let(:Authorization) { 'Bearer token' }
          let(:input) { nil }
          let(:organization) { create(:organization) }
          let(:id) { organization.id }

          before { sign_in(user) }
        end
      end

      response(422, 'validation failed') do
        let!(:address) { create(:address, addressable: organization) }
        let!(:admin_role) { create(:admin_role, user: admin) }

        let(:organization) { create(:organization) }
        let(:admin) { create(:admin) }

        let(:Authorization) { 'Bearer token' }
        let(:id) { organization.id }

        let(:valid_input) do
          attributes_for(:organization).merge(address: attributes_for(:address))
        end

        before { sign_in(admin) }

        it_behaves_like 'invalid field', description: 'when identifier invalid format' do
          let(:key) { [:identifier] }
          let(:value) { 'wrong identifier' }
          let(:key_message) { 'is in invalid format' }
        end

        it_behaves_like 'invalid field', description: 'when address invalid post_code format' do
          let(:key) { %i[address post_code] }
          let(:value) { '12sa1!213@' }
          let(:key_message) { 'is in invalid format' }
        end
      end

      response(404, 'not found') do
        let!(:admin_role) { create(:admin_role, user: admin) }

        let(:organization) { create(:organization) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:id) { 0 }
        let(:input) { nil }
        let(:search_param) { { id: id } }

        before { sign_in(admin) }

        include_examples 'not found response', klass: 'Organization'
      end
    end
  end
end
