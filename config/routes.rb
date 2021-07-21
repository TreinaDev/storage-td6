Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :suppliers, only: %i[index new create show] do
    post :change_active, on: :member
  end

  resources :warehouses, only: %i[new show create]
  resources :users, only: %i[index new create]

  namespace :api do
    namespace :v1 do
      post 'reserve', param: :sku, to: 'items#reserve'
    end
  end
end
