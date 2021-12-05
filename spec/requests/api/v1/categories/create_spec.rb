# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/categories#create', type: :request do
  path '/api/v1/categories' do
    post('Create new category') do
      tags 'Categories'

      security [bearer_auth: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  required: %w[name],
                  properties: {
                    name: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Categories::CreateContract::NAME_MAX_LENGTH
                    }
                  }
                }

      response(201, 'successful') do
        let!(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:input) { attributes_for(:category) }

        schema '$ref': '#/components/schemas/category_schema'

        before { sign_in(admin) }

        context 'when successful request' do
          let(:example_schema) { { '$ref': '#/components/schemas/category_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['category']['id']).not_to be_nil
            expect(json['category']['name']).to eq(input[:name])
          end
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

      response(422, 'validation failed') do
        let(:user) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:valid_input) { attributes_for(:category) }

        before { sign_in(user) }

        it_behaves_like 'invalid field', description: 'when name is missing' do
          let(:key) { [:name] }
          let(:value) { '' }
          let(:key_message) { 'must be filled' }
        end
      end
    end
  end
end
