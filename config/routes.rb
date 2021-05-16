Rails.application.routes.draw do
  get '/', to: 'users#show'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'


  match '/auth/:google_oauth2/callback' => 'sessions#google', via: [:get, :post]

  resources :user_books

  resources :users do
    resources :user_books
  end


  get '/:anything', to: 'application#wrong_page'
end