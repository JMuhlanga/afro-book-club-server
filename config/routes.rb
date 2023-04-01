Rails.application.routes.draw do
  # routes for sessions controller
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # routes for users controller
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  # routes for books controller
  resources :books, except: [:index]

  # routes for comments controller
  resources :comments, only: [:create, :destroy]

  # routes for ratings controller
  resources :ratings, only: [:create]
end

