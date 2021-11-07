# frozen_string_literal: true

module API
  module V1
    class BaseController < ActionController::API
      include ErrorsHandler
    end
  end
end
