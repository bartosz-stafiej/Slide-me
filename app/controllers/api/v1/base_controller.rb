# frozen_string_literal: true

require 'pagy/extras/headers'

module Api
  module V1
    class BaseController < ActionController::API
      include ErrorsHandler
      include ActionPolicy::Controller

      before_action :authenticate_user!

      after_action :merge_pagination_headers_if_present

      private

      def merge_pagination_headers_if_present
        pagy_headers_merge(@pagy) if @pagy
      end

      def authorize!(resource, context: auth_context, **options)
        super
      end

      def authorized_scope(relation, context: auth_context, **options)
        super
      end

      def auth_context
        {
          user: current_user,
          organization: @organization
        }
      end

      def validate!(contract)
        result = contract.call(params.to_unsafe_h)
        raise Controllers::Errors::Api::ValidationFailed, result.errors.to_h if result.failure?

        result
      end

      def me?
        params[:me_scope] == true
      end
    end
  end
end
