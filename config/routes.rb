Rails.application.routes.draw do
  devise_for :users

  resources :suppliers, only: %i[index new create show]
end
