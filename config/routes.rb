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

  get '/books', to: 'books#index'
  get '/books/new', to: 'books#new'
  post '/books', to: 'books#create'
  get '/books/:id', to: 'books#show', as: 'book'
  get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  patch '/books/:id', to: 'books#update'
  put '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'

  post '/books/:book_id/comments', to: 'comments#create', as: 'book_comments'
  delete '/comments/:id', to: 'comments#destroy', as: 'comment'

  post '/books/:book_id/ratings', to: 'ratings#create', as: 'book_ratings'
  patch '/ratings/:id', to: 'ratings#update', as: 'rating'
  delete '/ratings/:id', to: 'ratings#destroy'

  
end
