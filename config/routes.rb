Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :comments
  resources :posts
  get '/*a', to: 'application#not_found'
  post '/auth/login', to: 'authentication#login'
  resources :users, param: :_username
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
