# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/categories#update', type: :request do
  path '/api/v1/categories/{id}' do
    put('update category') do
      tags 'Categories'

      security [bearer_auth: []]

      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  properties: {
                    name: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Categories::UpdateContract::NAME_MAX_LENGTH
                    }
                  }
                }

      response(200, 'successful') do
        schema '$ref': '#/components/schemas/category_schema'

        let!(:id) { category.id }
        let(:category) { create(:category, creator: admin) }
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:input) { { name: 'New Category' } }

        before { sign_in(admin) }

        run_test! do |response|
          json = parse(response.body)
          expect(json['category']['id']).to eq(id)
          expect(json['category']['name']).to eq(input[:name])
        end
      end

      response(403, 'forbidden') do
        include_examples 'forbidden response' do
          let(:user) { create(:user) }
          let(:Authorization) { 'Bearer token' }
          let(:input) { nil }
          let(:id) { 0 }

          before { sign_in(user) }
        end
      end

      response(404, 'not_found') do
        let(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:input) { nil }
        let(:id) { 0 }
        let(:search_param) { { id: id } }
        before { sign_in(admin) }

        include_examples 'not found response', klass: 'Category'
      end
    end
  end
end
