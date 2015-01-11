Tombstone::Application.routes.draw do

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "wallet", to: "pages#wallet", as: "wallet"
  
      
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
    
  end
  
  resources :wallets
  resources :claims
  resources :preferences
end
