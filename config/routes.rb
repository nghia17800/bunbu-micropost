Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/signup",  to: "users#new"
  resources :users 
end
