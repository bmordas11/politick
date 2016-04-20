Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'

  resources :politicians do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :admins
end
