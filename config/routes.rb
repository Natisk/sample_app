Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help' # FIXME: into 'controller' section!
  get    '/about',   to: 'static_pages#about' # FIXME: into 'controller' section!
  get    '/contact', to: 'static_pages#contact' # FIXME: into 'controller' section!

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # EXAMPLE
  # controller :static_pages do
  #   get :help
  #   ...
  # end

  resources :users do
    member do
      get :following, :followers
    end
  end
  get '/signup',  to: 'users#new'

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end