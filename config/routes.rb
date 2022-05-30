Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :products, only: %i[index new create show]
  resources :shipping_companies, only: %i[index show new create] do
    resources :vehicles, only: %i[index new create show]
    resources :prices, only: %i[index new create]
  end
end
