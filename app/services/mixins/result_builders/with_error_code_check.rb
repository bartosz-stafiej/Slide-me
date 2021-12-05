# frozen_string_literal: true

module Mixins
  module Services
    module ResultBuilders
      module WithErrorCodeCheck
        protected

        def build_result(output: nil, error: nil)
          code = check_error_code(error) if error
          ::Services::Result.new(output: output, error: code)
        end

        private

        def check_error_code(code)
          self.class::ERROR_CODES.fetch(code) do
            "Unknown error code (#{code}), expected one of: #{self.class::ERROR_CODES.keys}"
          end
        end
      end
    end
  end
end
