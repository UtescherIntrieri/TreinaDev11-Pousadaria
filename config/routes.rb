Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :hosts
  
  resources :hosts, only: [:show] do
  end
  
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    patch :activate, on: :member
    
    resources :rooms, only: [:show, :new, :create, :edit, :update, :destroy] do
      patch :vacancy, on: :member

      resources :adjusted_prices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end
end
