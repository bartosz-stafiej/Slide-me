# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: %i[index create update destroy]

      resources :organizations, only: %i[index show create update destroy]

      resources :users, only: %i[] do
        collection do
          get :me

          resource :me, me_scope: true, only: %i[] do
            resources :organizations, only: %i[index show update]
          end
        end
      end
    end
  end
end
