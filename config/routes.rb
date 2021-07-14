Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :warehouses, only: %i[new show create]
end
