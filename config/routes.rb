Rails.application.routes.draw do
  root to: 'home#index'
  resources :car_categories 
  resources :rental_subsidiaries
  resources :car_models, only: [:index, :show, :new, :create]
end
