Rails.application.routes.draw do
  # Users
  resources :users, only: [:index, :show, :create, :update, :destroy]

  # Products
  resources :products, only: [:index, :show, :create, :update, :destroy]

  # Sales
  resources :sales, only: [:index, :show, :create, :update, :destroy]

  # Orders
  resources :orders, only: [:index, :show, :create, :update, :destroy]

  # OrderDetails
  resources :order_details, only: [:index, :show, :create, :update, :destroy]

  # Deliveries
  resources :deliveries, only: [:index, :show, :create, :update, :destroy]

  # Meetings
  resources :meetings, only: [:index, :show, :create, :update, :destroy]

  # Expenses
  resources :expenses, only: [:index, :show, :create, :update, :destroy]

  # Notifications
  resources :notifications, only: [:index, :show, :create, :update, :destroy]

  # Root route (optional, can be used to point to a default controller action)
  root "users#index"
end
