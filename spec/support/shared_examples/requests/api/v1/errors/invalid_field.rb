# frozen_string_literal: true

shared_examples 'invalid field' do |description:|
  context description do
    stringify = ->(e) { e.is_a?(Symbol) || e.is_a?(Integer) ? e.to_s : e }

    let(:expected_message) { I18n.t!('errors.api.validation_failed.default_message') }
    let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

    let(:input) do
      next invalid_input if respond_to?(:invalid_input)
      next valid_input.merge(key.first => value) if key.size == 1

      invalid = valid_input.dup
      invalid.dig(*key[0..-2])[key.last] = value
      invalid
    end

    run_test! do |response|
      json = parse(response.body)
      expect(json['error']).to eq(expected_message)
      expect(json['details'].dig(*key.map(&stringify))).to eq([key_message])
    end
  end
end
