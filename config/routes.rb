Rails.application.routes.draw do
  get "/", to: "home#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :update, :show]
    end
  end
end
