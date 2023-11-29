Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :guests
  devise_for :hosts
  
  resources :guests, only: [:show]

  resources :confirmation, only: [:index, :create]

  resources :hosts, only: [:show] do
    get 'review_index', on: :member
    resources :reservations, only: [:index] do
      get 'review_show', on: :member
    end
  end
  
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    patch :activate, on: :member
    get 'city_search', on: :collection
    get 'search', on: :collection
    get 'adv_search', on: :collection
    get 'inn_reviews', on: :member
    
    
    resources :rooms, only: [:show, :new, :create, :edit, :update, :destroy] do
      patch :vacancy, on: :member

      resources :reservations, only: [:show, :new, :create, :edit, :update] do
        patch :activate, on: :member
        patch :cancel, on: :member
        patch :finish, on: :member
      end

      resources :adjusted_prices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :inns, only: [:show, :index] do
        resources :rooms, only: [:show, :index] do
          get 'check', on: :member
        end
      end
    end
  end
end
