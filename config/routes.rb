# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :session
  resources :passwords, param: :token

  namespace :v1 do
    # Public
    namespace :guest_space do
      get 'landing_neighborhoods', to: 'neighborhoods#index'
      get 'landing_listings', to: 'listings#index'
    end

    # Auth & Profile
    resource :session, only: %i[create destroy]
    resource :user, only: %i[create update]
    resource :profile, only: %i[show update]

    # Core Features
    get 'dashboard', to: 'dashboards#index'

    resources :relocation_plans, only: %i[show create index] do
      resources :move_timeline_items, only: %i[index create update destroy]
    end

    # Listings
    resources :listings, only: %i[index]
    resources :saved_listings, param: :listing_id, only: %i[index create destroy]

    # Data
    resources :states, only: %i[index]
    resources :cities, only: %i[index]
    resources :neighborhoods, only: %i[index]
    resources :amenities, only: %i[index]
  end
end
