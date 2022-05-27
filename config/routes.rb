Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :shipping_companies, only: [:index, :show, :new, :create] do
    resources :vehicles, only: [:index, :new, :create, :show]
  end
end
