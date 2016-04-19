Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'

  resources :politicians, only: [:index, :create] do
    resources :comments, only: [:create]
  end
end
