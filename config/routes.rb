Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories 
  resources :rental_subsidiaries
  resources :car_models, only: [:index, :show, :new, :create]

  get 'clients/search', to: 'clients#search'
  resources :clients, only: [:index,:new, :create, :show]

  get 'rentals/search', to: 'rentals#search'
  resources :rentals, only: [:index, :show, :new, :create, ]

  # mesma coisa que '/api/v1/cars', to 'api/v1/cars#index'
  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index, :show, :create, :destroy]
      #resources :cars, only: %i[index]
    end
  end
  
end
