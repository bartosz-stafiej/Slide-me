# frozen_string_literal: true

Rails.application.routes.draw do
  constraints(-> { ENV['SWAGGER_UI_ENABLED'] == 'true' }) do
    namespace :docs do
      mount Rswag::Ui::Engine, at: 'api'
      mount Rswag::Api::Engine, at: 'api'
    end
  end

  devise_for :users

  draw(:api_v1)
end
