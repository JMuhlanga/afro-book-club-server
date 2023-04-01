Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  resources :ratings
  resources :comments
  resources :books
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
