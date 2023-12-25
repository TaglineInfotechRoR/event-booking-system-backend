# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  require 'sidekiq/web'
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"
  mount Sidekiq::Web, at: '/sidekiq'
  # Defines the root path route ("/")
  # root "posts#index"
  namespace 'api' do
    namespace 'v1', defaults: { format: :json } do
      # event orgainzer auth
      post '/organizer/login', to: 'sessions#login'
      post '/organizer/sign_up', to: 'event_organizers#create'

      # Customer auth routes
      post '/customer/login', to: 'sessions#customer_login'
      post '/customer/sign_up', to: 'customers#create'

      resources :events # Event routes
      resources :tickets, only: %i[update destroy] # Ticket routes

      resources :bookings, only: %i[create] # Booking routes
    end
  end
end
