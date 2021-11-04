# frozen_string_literal: true

module API
  module V1
    class ErrorsHandler
      extend ActiveSupport::Concern

      included do
        handle500 = [Rails.env.development?, Rails.env.test?].none?
        rescue_from StandardError, with: :handle_internal_error if handle500

        rescue_from Errors::API::BaseError, with: :handle_api_error
        rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      end

      private

      def validation_failed(validation_result)
        raise Controllers::Errors::API::V1::ValidationFailed, validation_result.errors.to_h
      end

      def handle_not_found(error)
        not_found = Controllers::Errors::API::V1::NotFound.new(error.message)
        handle_api_error(not_found)
      end

      def handle_internal_error(_)
        not_found = Controllers::Errors::API::V1::NotFound.new
        handle_api_error(not_found)
      end

      def handle_api_error(error)
        serialized_error =
          case error
          when Controller::Errors::API::V1::ValidationFailed
            { error: error.message, details: error.details }
          else
            { error: error.message }
          end

        render json: serialized_error, status: error.status
      end
    end
  end
end
