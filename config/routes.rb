Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :suppliers, only: %i[index new create show] do
    post :change_active, on: :member
  end

  resources :warehouses, only: %i[new show create]
  resources :users, only: %i[index new create]
  resources :product_entries, only: %i[index show new create]
end
