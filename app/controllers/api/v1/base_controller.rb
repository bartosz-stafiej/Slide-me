# frozen_string_literal: true

module API
  module V1
    class BaseController < ApplicationController::API
      include ErrorsHandler
    end
  end
end
