# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      if current_user
        render json: { message: I18n.t('devise.sessions.signed_in') }, status: :ok
      else
        render json: { message: I18n.t('devise.failure.invalid', authentication_keys: 'email') }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      log_out_failure && return if current_user

      log_out_success
    end

    def log_out_success
      render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
    end
  end
end
