# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/categories#index', type: :request do
  path '/api/v1/categories' do
    get('Index all categories') do
      tags 'Categories'

      security [bearer_auth: []]

      consumes 'application/json'

      include_context 'pagination parameters'

      response(200, 'successful') do
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }

        schema '$ref': '#/components/schemas/categories_schema'

        before { sign_in(admin) }

        context 'when some categories' do
          let!(:category) { create(:category, creator: admin) }
          let(:example_schema) { { '$ref': '#/components/schemas/categories_schema' } }

          run_test! do
            json = parse(response.body)
            expect(json['categories'][0]['id']).to eq(category.id)
          end
        end

        context 'when no categories' do
          let(:example_schema) { { '$ref': '#/components/schemas/categories_schema' } }

          run_test! do |response|
            json = parse(response.body)
            expect(json['categories']).to be_empty
          end
        end
      end

      response(400, 'bad request') do
        include_examples 'invalid pagination parameter' do
          let(:user) { create(:user) }
          let(:items) { 'invaliditems' }
          let(:Authorization) { 'Bearer token' }

          before { sign_in(user) }
        end
      end
    end
  end
end
