Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
<<<<<<< HEAD

  resources :suppliers, only: %i[index new create show]
=======
  resources :warehouses, only: %i[new show create]
>>>>>>> d98ac638e0ff45ada630a17a20288b24fbbe0a28
end
