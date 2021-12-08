# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: %i[index create update destroy]

      resources :organizations, only: %i[create]
    end
  end
end
