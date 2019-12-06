Rails.application.routes.draw do
  get 'favorites/good'
  get 'favorites/favorite'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root to: 'sessions#new'
  resources :posts
  post '/posts/change'
  get '/users/:user_id/admin', to: 'users#admin'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
