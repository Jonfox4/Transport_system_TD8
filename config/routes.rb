Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :orders, only: %i[index new create]
  resources :products, only: %i[index new create show]

  resources :shipping_companies, only: %i[index show new create] do
    resources :vehicles, only: %i[index new create show]
    resources :prices, only: %i[index new create]
    resources :time_deliveries, only: %i[index new create]
  end
end
