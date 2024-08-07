Rails.application.routes.draw do
  # API routes for Users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show, :create, :update, :destroy]

  # Other resources for your app
  resources :products, only: [:index, :show, :create, :update, :destroy]
  resources :sales, only: [:index, :show, :create, :update, :destroy]
  resources :orders, only: [:index, :show, :create, :update, :destroy]
  resources :order_details, only: [:index, :show, :create, :update, :destroy]
  resources :deliveries, only: [:index, :show, :create, :update, :destroy]
  resources :meetings, only: [:index, :show, :create, :update, :destroy]
  resources :expenses, only: [:index, :show, :create, :update, :destroy]
  resources :notifications, only: [:index, :show, :create, :update, :destroy]

  # Root route (optional, can be used to point to a default controller action)
  root "users#index"
end
