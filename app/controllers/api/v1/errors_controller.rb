# frozen_string_literal: true

module API
  module V1
    class ErrorsController < BaseController
      def route_not_found
        message = I18n.t('errors.api.not_found.route',
                         method: request.method,
                         url: request.original_fullpath)

        raise Controller::Errors::API::NotFound, message
      end
    end
  end
end