Rails.application.routes.draw do
  devise_for :users
  match 'users/:id' => 'users#destroy', via: :delete, as: :admin_destroy_user
  root 'politicians#index'

  resources :politicians do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :admins

  scope module: 'api' do
    namespace :v1 do
      get '/upvote/' => 'comment_votes#upvote'
      get '/downvote/' => 'comment_votes#downvote'
      post '/addComment/' => 'comment#add_comment'
    end
  end
end
