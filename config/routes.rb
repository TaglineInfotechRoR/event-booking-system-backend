# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
  mount Sidekiq::Web, at: '/sidekiq'

  namespace 'api' do
    namespace 'v1', defaults: { format: :json } do
      # Event orgainzer auth
      post '/organizers/login', to: 'sessions#organizer_login'
      post '/organizers/sign_up', to: 'event_organizers#create'

      # Customer auth
      post '/customers/login', to: 'sessions#customer_login'
      post '/customers/sign_up', to: 'customers#create'

      resources :events
      resources :customers, only: %i[update destroy]
      resources :event_organizers, only: %i[update destroy]
      resources :tickets, only: %i[update destroy]
      resources :bookings, only: %i[create]
    end
  end
end
