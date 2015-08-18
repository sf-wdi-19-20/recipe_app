Rails.application.routes.draw do

  # users routes
  get "/signup", to: "users#new"
  get "/profile", to: "users#show"
  resources :users, only: [:create]

  # sessions routes
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
  # post "/sessions", to: "sessions#create"
  resources :sessions, only: [:create]

  # recipes routes
  root "recipes#index"
  resources :recipes, except: [:index]

  # favorites routes
  resources :favorites, only: [:create]
  
end