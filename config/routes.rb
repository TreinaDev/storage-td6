Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :warehouses, only: %i[new show create]

  namespace :api do
    namespace :v1 do
      post 'reserve', param: :sku, to: 'items#reserve'
    end
  end
end
