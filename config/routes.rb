Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'posts#index'

  resources :users do 
    # TODO make profiles singular resource 
    resource :profile, only: [:new, :edit, :show, :update]
    resources :posts
  end

  resources :profiles
  
  resources :posts do 
    resources :likings, only: [:create]
    resources :comments, only: [:create, :destroy]
  end

  resources :comments do 
    resources :likings, only: [:create]
    resources :comments, only: [:create, :destroy]
  end

  resources :likings, only: [:destroy]
  resource  :session
end
