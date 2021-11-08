Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup",  to: "users#new"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts
  resources :relationships, only: [:create, :destroy]
end
