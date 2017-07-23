Rails.application.routes.draw do
  root to: "home#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :show]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update, :show]
      resources :recipes, only: [:index, :show, :update, :create]
      resources :ingredients, only: [:create, :update]
      resources :categories, only: [:index, :create, :update]
      resources :recipe_categories, only: [:destroy]
    end
  end
end
