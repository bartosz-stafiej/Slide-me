# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch('CORS_ALLOWED_ORIGIN')

    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[
        Authorization
        Page-Items
        Total-Pages
        Total-Count
        Current-Page
      ]
  end
end