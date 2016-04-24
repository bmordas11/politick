Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'

  resources :politicians do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :admins

  scope module: 'api' do
    namespace :v1 do
      get '/upvote/' => 'comment_votes#upvote'
      get '/downvote/' => 'comment_votes#downvote'
    end
  end
end
