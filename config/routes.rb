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
      namespace :freightage do
        resources :warehouses, only: %i[] do 
          get ':sku', on: :collection, param: :sku, to: 'warehouses#list'
        end
      end
    end
  end
end
