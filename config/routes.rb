Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show] do
    resources :wikis, shallow: true
  end
  
  resources :wikis, only: [:index]
  resources :charges, only: [:new, :create]
  delete '/downgrade', to: 'charges#downgrade'
  
  authenticated do
    root to: "users#show", as: :authenticated
  end
  
  root to: 'welcome#index'
  
end
