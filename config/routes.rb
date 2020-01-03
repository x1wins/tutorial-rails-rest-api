Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  resources :comments
  resources :posts
  post '/auth/login', to: 'authentication#login'
  resources :users, param: :_username
  get '/*a', to: 'application#not_found'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
