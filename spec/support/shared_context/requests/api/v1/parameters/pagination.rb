# frozen_string_literal: true

shared_context 'pagination parameters' do
  parameter name: :items, in: :query, required: false,
            schema: {
              type: :integer,
              default: Pagy::VARS[:items],
              minimum: 1,
              maximum: Pagy::VARS[:max_items]
            }
end
