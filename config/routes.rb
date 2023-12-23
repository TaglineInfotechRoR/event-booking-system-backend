# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace 'api' do
    namespace 'v1', defaults: { format: :json } do
      # customer auth
      post '/customer/login', to: 'sessions#customer_login'
      post '/customer/sign_up', to: 'customers#create'
      # event orgainzer auth
      post '/organizer/login', to: 'sessions#login'
      post '/organizer/sign_up', to: 'event_organizers#create'
    end
  end
end
