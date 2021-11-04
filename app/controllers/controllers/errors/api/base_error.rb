# frozen_string_literal: true

module Controllers
  module Errors
    module API
      class BaseError < StandardError
        attr_reader :status

        def initlize(message, status)
          super(message)
          @status = status
        end
      end
    end
  end
end
