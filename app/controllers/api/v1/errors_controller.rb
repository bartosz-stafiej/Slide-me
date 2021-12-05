# frozen_string_literal: true

module Api
  module V1
    class ErrorsController < ActionController::API
      include ErrorsHandler

      def route_not_found
        message = I18n.t('errors.api.not_found.route',
                         method: request.method,
                         url: request.original_fullpath)

        raise Controller::Errors::Api::NotFound, message
      end
    end
  end
end
