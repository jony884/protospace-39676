Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  root 'prototypes#index'

  resources :users, only: [:edit, :update, :show]
  
  resources :prototypes do
    resources :comments, only: :create
  end

end
