# frozen_string_literal: true

module Api
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      handle500 = [Rails.env.development?, Rails.env.test?].none?
      rescue_from StandardError, with: :handle_internal_error if handle500

      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      rescue_from Controllers::Errors::Api::BaseError, with: :handle_api_error
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from Pagy::VariableError, with: :handle_pagy_variable_error
      rescue_from ActionPolicy::Unauthorized, with: :handle_unauthorized
    end

    private

    def validation_failed(validation_result)
      raise Controllers::Errors::Api::ValidationFailed, validation_result.errors.to_h
    end

    def handle_unauthorized
      forbidden = Controllers::Errors::Api::Forbidden.new
      handle_api_error(forbidden)
    end

    def handle_pagy_variable_error(error)
      bad_request = Controllers::Errors::Api::BadRequest.new(error.message)
      handle_api_error(bad_request)
    end

    def handle_parameters_parse_error(_error)
      message = I18n.t('errors.api.bad_request.parameters_parse_error')
      bad_request = Controllers::Errors::API::BadRequest.new(message)
      handle_api_error(bad_request)
    end

    def handle_not_found(error)
      not_found = Controllers::Errors::Api::NotFound.new(error.message)
      handle_api_error(not_found)
    end

    def handle_internal_error(_)
      not_found = Controllers::Errors::Api::NotFound.new
      handle_api_error(not_found)
    end

    def handle_api_error(error)
      serialized_error =
        case error
        when Controllers::Errors::Api::ValidationFailed
          { error: error.message, details: error.details }
        else
          { error: error.message }
        end

      render json: serialized_error, status: error.status
    end
  end
end
