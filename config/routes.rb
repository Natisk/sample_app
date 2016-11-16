Rails.application.routes.draw do

  devise_for :users
  root   'static_pages#home'

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
  get '/signup',  to: 'devise/registrations#new'

  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end