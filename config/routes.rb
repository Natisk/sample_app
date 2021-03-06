Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root   'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/robot', to: 'static_pages#robot'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  get '/signup',  to: 'users/registrations#new'

  devise_scope :user do
    get    '/login',   to: 'devise/sessions#new'
    post   '/login',   to: 'devise/sessions#create'
    delete '/logout',  to: 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :following, :followers
    end
  end

  resources :personal_messages, only: [:create]

  resources :conversations, only: [:index, :show]

  resources :personal_messages, only: [:new, :create]

  resources :chat_rooms, only: [:index, :new, :create, :show, :destroy]

  resources :microposts, only: [:create, :destroy, :edit, :update] do
    resources :comments, only: [:index, :create, :destroy]
    post '/like',    to: 'microposts#like_post'
    post '/dislike', to: 'microposts#dislike_post'
  end
  get '/abyss',   to: 'microposts#index'

  resources :relationships,         only: [:create, :destroy]
  resources :omniauth,              only: [:destroy]
end