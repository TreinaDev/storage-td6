Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :suppliers, only: %i[index new create show] do
    #put 'change_active', to:"suppliers#change_active", on: :member
    put :change_active, on: :member
  end

  resources :warehouses, only: %i[new show create]
end
