Rails.application.routes.draw do

  root 'posts#index'

  get 'users/top' => 'users#top'

  devise_for :users

  resources :users, only: [:create, :show, :edit, :top, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :followings,       only: [:create, :destroy]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
