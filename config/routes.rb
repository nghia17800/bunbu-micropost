Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  as :user do
    get "/login", to: "devise/sessions#new"
    post "/login", to: "devise/sessions#create"
    delete "/logout", to: "devise/sessions#destroy"
    get "/signup", to: "devise/registrations#new"
  end
  devise_for :users
  resources :posts do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show, :index] do
    member do
      get :following, :followers
    end
  end
  get "/auth/:provider/callback", to: "sessions#omniauth"
  get "/auth/facebook/callback", to: "omniauth_callbacks#facebook"
end
