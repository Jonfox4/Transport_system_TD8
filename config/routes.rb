Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :shipping_companies, only: [:index, :show, :new, :create]
  resources :vehicle, only: [:new, :create]
end
