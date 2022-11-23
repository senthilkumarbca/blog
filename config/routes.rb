Rails.application.routes.draw do


  devise_for :users
  resources :users, only: [:show]
  resources :tags
  resources :topics do
    resources :posts, only: %i[index destroy show edit update]
  end
  resources :posts, only: %i[index new create] do
    resources :comments do
      resources :user_comment_ratings
    end
    resources :ratings
  end

  root 'posts#index'
end
