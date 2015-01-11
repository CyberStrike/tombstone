Tombstone::Application.routes.draw do

  root to: "pages#home"
  get "home", to: "pages#home", as: "home"
  # get "wallet", to: "pages#wallet", as: "wallet"
  get "get_keys", to: "pages#get_keys", as: "keys"
  post "create_keys", to: "pages#create_keys"

  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
    
  end
  
  resources :wallets
  resources :claims
  resources :preferences
end
