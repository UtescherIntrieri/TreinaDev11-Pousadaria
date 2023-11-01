Rails.application.routes.draw do
  root to: 'home#index'
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    patch :activate, on: :member
  end
end
