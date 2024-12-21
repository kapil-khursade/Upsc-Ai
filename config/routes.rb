require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/upsc_ai_mobile", to: "graphql#execute"
  post '/login_upsc_ai_mobile', to: 'graph_ql_sessions#create' # Login endpoint
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  authenticate :admin_user, lambda { |u| u } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :internal_api do
    resources :create_order, only: [:create]
    resources :update_payment, only: [:create]
    resources :refresh_status, only: [:index]
  end

  namespace :mobile_app_api do
    resources :login, only: [:create]
    resources :validate_auth_token, only: [:index]
    resources :user_profile_data, only: [:index]
    resources :get_questions, only: [:index]
    resources :create_question, only: [:create]
  end

  resources :fetch_data, only: [:index]

  root to: "admin/dashboard#index"

end
