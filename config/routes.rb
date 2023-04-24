Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :forecast, only: %i[show]
    end
  end

  get '/api/v1/forecast', to: 'api/v1/forecast#index'
end
