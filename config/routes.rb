Rails.application.routes.draw do

  root   'static_pages#home'

  devise_for :users
  get '/signup',  to: 'devise/registrations#new'

  controller :static_pages do
    get :help
    get :about
    get :contact
  end

  devise_scope :user do
    get    '/login',   to: 'devise/sessions#new'
    post   '/login',   to: 'devise/sessions#create'
    delete '/logout',  to: 'devise/sessions#destroy'
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments
  end
  resources :microposts,          only: [:create, :destroy]
  get '/abyss',   to: 'microposts#index'

  resources :relationships,       only: [:create, :destroy]
end