Rails.application.routes.draw do
  root to: 'home#index'
  resources :inns, only: [:show, :new, :create, :edit, :update]
end
