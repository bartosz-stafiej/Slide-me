# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('CORS_ALLOWED_ORIGIN')

    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[uid client access-token token-type expiry]
  end
end