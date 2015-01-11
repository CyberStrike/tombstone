Tombstone::Application.routes.draw do
  resources :wallets

  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
      
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
    
  end

  resources :claims
  resources :preferences
end
