Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :suppliers, only: %i[index new create show]
  resources :warehouses, only: %i[new show create]
  resources :users, only: %i[index new create]
end
