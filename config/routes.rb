Rails.application.routes.draw do
  get '/', to: 'users#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

resources :user_books

  # resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :user_books
  end


  get '/:anything', to: 'application#wrong_page'
end