Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'users#index'

  resources :users do 
    resources :profiles, only: [:new, :edit, :show, :update]
  end
  resource  :session
end
