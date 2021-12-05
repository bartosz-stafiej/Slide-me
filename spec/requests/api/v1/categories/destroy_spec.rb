# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/categories#destroy', type: :request do
  path '/api/v1/categories/{id}' do
    delete('Destroy new category') do
      tags 'Categories'

      security [bearer_auth: []]

      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      response(204, 'successful') do
        let!(:admin) { create(:admin) }
        let(:Authorization) { 'Bearer token' }
        let(:category) { create(:category) }
        let(:id) { category.id }

        before { sign_in(admin) }

        context 'when successful request' do
          run_test!
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
