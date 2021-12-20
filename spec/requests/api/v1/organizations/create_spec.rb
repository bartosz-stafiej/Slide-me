# frozen_string_literal: true

require 'swagger_helper'
require 'constants/addresses/field_max_lengths'
require 'constants/addresses/field_formats'

RSpec.describe 'api/v1/organizations#create', type: :request do
  path '/api/v1/organizations' do
    post('Create new organization') do
      tags 'Organizations'

      security [bearer_auth: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  required: %w[name address],
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
                      required: %w[post_code city country address_line],
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

      response(201, 'successful') do
        let!(:user) { create(:user) }
        let(:Authorization) { 'Bearer token' }
        let(:input) do
          attributes_for(:organization).merge(address: attributes_for(:address))
        end

        schema '$ref': '#/components/schemas/organization_schema'

        before { sign_in(user) }

        context 'when successful request (it create owner role)' do
          let(:example_schema) { { '$ref': '#/components/schemas/organization_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['organization']['id']).not_to be_nil
            expect(json['organization']['name']).to eq(input[:name])
            expect(json['organization']['address']['address_line']).to eq(input[:address][:address_line])

            org = user.organizations.find_by(id: json['organization']['id'])
            expect(org_roles(user: user, org_id: org.id)).to include('owner')
          end
        end
      end

      response(422, 'validation failed') do
        let(:user) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:valid_input) { attributes_for(:category) }

        before { sign_in(user) }

        it_behaves_like 'invalid field', description: 'when identifier invalid format' do
          let(:key) { [:identifier] }
          let(:value) { 'wrong identifier' }
          let(:key_message) { 'is in invalid format' }
        end

        it_behaves_like 'invalid field', description: 'when address is missing' do
          let(:key) { [:address] }
          let(:value) { nil }
          let(:key_message) { 'must be a hash' }
        end
      end
    end
  end
end
