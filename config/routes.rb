Rails.application.routes.draw do
  root to: 'home#index'
  resources :car_categories, :rental_subsidiaries
end
