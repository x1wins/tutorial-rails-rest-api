Rails.application.routes.draw do
  root to: "application#not_found"
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :comments
      resources :posts
      # DELETE /posts/destroy_attached/:attached_id
      delete '/posts/:id/destroy_attached/:attached_id', to: 'posts#destroy_attached'
      post '/auth/login', to: 'authentication#login'
      resources :users, param: :_username
    end
  end

  # get '/*a', to: 'application#not_found'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
