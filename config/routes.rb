Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories 
  resources :rental_subsidiaries
  resources :car_models, only: [:index, :show, :new, :create]
  resources :clients, only: [:index,:new, :create, :show]
  resources :rentals, only: [:index, :show, :new, :create, ]

  get 'search', to: 'clients#search'
end
