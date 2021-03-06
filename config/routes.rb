Rails.application.routes.draw do
  resources :user_mirrors, only: [:new, :create, :index, :show]

  resources :users_sessions, only: [:new, :create]
  resources :mirrors_sessions, only: [:new, :create]

  resources :users do 
    resources :mirrors
  end

  resources :mirrors

  # patch '/users/:id/posts/', to: 'posts#update'
  root 'users#index'
  get '/logout/users' => 'users_sessions#destroy'
  get '/logout/mirrors' => 'mirrors_sessions#destroy'
end
