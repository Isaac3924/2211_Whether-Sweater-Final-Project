Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :forecast, only: %i[index]
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
    end
  end
end
