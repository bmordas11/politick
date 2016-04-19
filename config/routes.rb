Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'

  resources :politicians, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
  end

  resources :admins
end
