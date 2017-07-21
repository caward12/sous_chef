Rails.application.routes.draw do
  get "/", to: "home#index"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update, :show]
      post "/login", to: "sessions#create"
      post "/logout", to: "sessions#destroy"
    end
  end
end
