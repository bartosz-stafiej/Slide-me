# frozen_string_literal: true

module Requests
  module API
    module V1
      module AuthHelpers
        def sign_in(user)
          login_as(user, scope: :user)
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Requests::API::V1::AuthHelpers, type: :request
  config.include Warden::Test::Helpers
end
