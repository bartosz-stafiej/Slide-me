# frozen_string_literal: true

shared_examples 'invalid pagination parameter' do
  context 'invalid pagination parameter' do
    let(:expected_message) { "expected :items >= 1; got \"#{items}\"" }
    let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

    run_test! do |response|
      json = parse(response.body)
      expect(json['error']).to eq(expected_message)
    end
  end
end
