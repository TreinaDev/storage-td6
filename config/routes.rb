Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :suppliers, only: %i[index new create show edit update] do
    post :change_active, on: :member
  end

  resources :warehouses, only: %i[index new show create]
  resources :users, only: %i[index new create edit update]
  resources :product_entries, only: %i[index show new create]
  resources :reserved_items, only: %i[index]
  resources :dispatch_logs, only: %i[create show]
  resources :items, only: %i[], param: :code do
    resources :dispatch_logs, only: %i[new]
  end

  post :create_entry_by_csv, to: 'product_entries#create_by_csv'

  namespace :api do
    namespace :v1 do
      post 'reserve', param: :sku, to: 'items#reserve'
      namespace :freightage do
        resources :warehouses, only: %i[] do 
          get ':sku', on: :collection, param: :sku, to: 'warehouses#list'
        end
      end
      namespace :ecommerce do
        resources :warehouses, only: %i[] do 
          get ':sku', on: :collection, param: :sku, to: 'warehouses#list'
        end
      end
    end
  end
end
