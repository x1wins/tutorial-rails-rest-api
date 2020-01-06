# tutorial-rails-rest-api

TODO
----
- [x] Generate porject ```rails new [Project Name] --api -T -d postgresql```
- [x] Database setting Gem https://github.com/x1wins/docker-postgres-rails
- [x] User scaffold and JWT for user authenticate Gem https://github.com/x1wins/jwt-rails
- [ ] Category scaffold
- [x] Post scaffold
- [x] Comment scaffold
- [x] Model Serializer https://itnext.io/a-quickstart-guide-to-using-serializer-with-your-ruby-on-rails-api-d5052dea52c5
- [x] Rspec https://relishapp.com/rspec/rspec-rails/docs/gettingstarted
- [ ] Swager https://github.com/rswag/rswag
- [ ] Pagnation https://github.com/ddnexus/pagy

How what to do
--------------
1. Gemfile
    ```bash
      gem 'active_model_serializers'
    ```

2. Scaffold
    ```bash
      rails g serializer user name:string username:string email:string
      rails g serializer post body:string user:references published:boolean
    ```
    ```bash
      rails g scaffold comment body:string post:references user:references published:boolean
      rails g serializer comment body:string user:references published:boolean
    ```
3. Controller
    ```ruby
      class CommentsController < ApplicationController
        before_action :authorize_request
        before_action :set_comment, only: [:show, :update, :destroy]
        before_action only: [:edit, :update, :destroy] do
          is_owner_object @comment ##your object
        end
        //...your code

        # Only allow a trusted parameter "white list" through.
        def comment_params
          params.require(:comment).permit(:body, :post_id).merge(user_id: @current_user.id)
        end
      end
    ```
3. Model
    ```ruby
      # app/models/post.rb
      class Post < ApplicationRecord
       belongs_to :user
       has_many :comments
      end
    ```
    ```ruby
      # app/models/comment.rb
      class Comment < ApplicationRecord
        belongs_to :post
        belongs_to :user
      end
    ```
    ```ruby
      # app/serializers/post_serializer.rb
      class PostSerializer < ActiveModel::Serializer
        attributes :id, :body, :user, :comments
        has_one :user
        has_many :comments
      end
    ```
    ```ruby
      # app/serializers/comment_serializer.rb
      class CommentSerializer < ActiveModel::Serializer
        attributes :id, :body, :user
        has_one :user
      end
    ```
    ```ruby
      # app/serializers/user_serializer.rb
      class UserSerializer < ActiveModel::Serializer
        attributes :id, :name, :username, :email
      end
    ```      
4. For Nested model serializer
    ```ruby
      # config/initializers/active_model_serializer.rb
      ActiveModelSerializers.config.default_includes = '**'
    ```

5. Faker
https://rubyinrails.com/2018/11/10/rails-building-json-api-resopnses-with-jbuilder/
    Gemfile
    ```ruby
      gem 'faker', '~> 1.9.1', group: [:development, :test]
    ```

6. CURL
    1. Join User
        ```bash
            curl -d '{"user": {"name":"ChangWoo", "username":"CW", "email":"x1wins@changwoo.org", "password":"hello1234", "password_confirmation":"hello1234"}}' -H "Content-Type: application/json" -X POST -i http://localhost:3000/users
            curl -d '{"user": {"name":"hihi", "username":"helloworld", "email":"hello@changwoo.org", "password":"hello1234", "password_confirmation":"hello1234"}}' -H "Content-Type: application/json" -X POST -i http://localhost:3000/users
        ```
    2. Login
        ```bash
            curl -d '{"email":"x1wins@changwoo.org", "password":"hello1234"}' -H "Content-Type: application/json" -X POST http://localhost:3000/auth/login | jq
            curl -d '{"email":"hello@changwoo.org", "password":"hello1234"}' -H "Content-Type: application/json" -X POST http://localhost:3000/auth/login | jq
        ```
    3. Create Post
        ```bash
            curl  -X POST -i http://localhost:3000/posts -d '{"post": {"body":"sample body text sample"}}' -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Nzc0OTAyNjJ9.PCY7kXIlImORySIeDd78gErhqApAyGP6aNFBmK_mdXY"
            curl  -X POST -i http://localhost:3000/posts -d '{"post": {"body":"hihihi ahaha"}}' -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Nzc0OTAyNjJ9.PCY7kXIlImORySIeDd78gErhqApAyGP6aNFBmK_mdXY"
            curl  -X POST -i http://localhost:3000/posts -d '{"post": {"body":"Average Speed   Time    Time     Time  Current"}}' -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1Nzc0OTMwMjl9.s9WqkyM84LQGZUtpmfmZzWN8rsVUp4_yfKfxEN_t4AQ"
        ```
    4. Index Post
        ```bash
            curl -X GET http://localhost:3000/posts -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Nzc0OTAyNjJ9.PCY7kXIlImORySIeDd78gErhqApAyGP6aNFBmK_mdXY" | jq
        ```
    5. Create Comment
        ```bash
            curl -X POST -i http://localhost:3000/comments -d '{"comment": {"body":"sample body for comment", "post_id": 2}}' -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Nzc0OTAyNjJ9.PCY7kXIlImORySIeDd78gErhqApAyGP6aNFBmK_mdXY"
        ```

7. Unit Testing with Rspec
    1. Config
        1. Gemfile
            ```ruby
                group :test do
                  gem 'rspec-rails', '~> 3.5'
                  gem 'database_cleaner'
                  gem 'factory_bot_rails'
                  gem 'faker'
                end
            ```
        2. Config for spec/support path
            Add this code for class in spec/support
            ```ruby
               # spec/rails_helper.rb
               Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
            ``` 
        3. spec/support/*
            ```bash
                $ mkdir spec/support/
                $ touch spec/support/api_helper.rb
                $ touch spec/support/database_cleaner.rb
                $ touch spec/support/factory_bot.rb
            ```
            ```ruby
                # spec/support/api_helper.rb
                module ApiHelper
                  def authenticated_header(options)
                    user = options[:user]
                    token = JsonWebToken.encode(user_id: user.id)
                    if options[:user] and options[:request]
                      request = options[:request]
                      request.headers.merge!('Authorization': "Bearer #{token}")
                    else
                      {"Authorization" => "Bearer #{token}"}
                    end
                  end
                end
         
                # spec/support/database_cleaner.rb
                RSpec.configure do |config|
                  config.before(:suite) do
                    DatabaseCleaner.clean_with(:truncation)
                  end
                
                  config.before(:each) do
                    DatabaseCleaner.strategy = :transaction
                  end
                
                  config.before(:each, :js => true) do
                    DatabaseCleaner.strategy = :truncation
                  end
                
                  config.before(:each) do
                    DatabaseCleaner.start
                  end
                
                  config.after(:each) do
                    DatabaseCleaner.clean
                  end
                end
    
                 # spec/support/factory_bot.rb
                 RSpec.configure do |config|
                   config.include FactoryBot::Syntax::Methods
                 end
            ```
    2. RSpec code
        1. Factories
            ```ruby
                 # spec/factories/user.rb
                 FactoryBot.define do
                   factory :post do
                     body  { Faker::Hacker.say_something_smart }
                     user  { :user }
                   end
                 end
                 # spec/factories/user.rb
                 FactoryBot.define do
                   factory :user do
                     name    { Faker::Name.name }
                     username    { name }
                     email    { Faker::Internet.email }
                     password { Faker::Internet.password }
                   end
                 end
            ```
        2. Requests
            ```ruby
                  # spec/requests/posts_spec.rb
                  require "rails_helper"
                  RSpec.describe PostsController, type: :routing do
                    describe "routing" do
                      it "routes to #index" do
                        expect(:get => "/posts").to route_to("posts#index")
                      end
                  
                      it "routes to #show" do
                        expect(:get => "/posts/1").to route_to("posts#show", :id => "1")
                      end
                  
                  
                      it "routes to #create" do
                        expect(:post => "/posts").to route_to("posts#create")
                      end
                  
                      it "routes to #update via PUT" do
                        expect(:put => "/posts/1").to route_to("posts#update", :id => "1")
                      end
                  
                      it "routes to #update via PATCH" do
                        expect(:patch => "/posts/1").to route_to("posts#update", :id => "1")
                      end
                  
                      it "routes to #destroy" do
                        expect(:delete => "/posts/1").to route_to("posts#destroy", :id => "1")
                      end
                    end
                  end
            ``` 
        3. Controllers
            if you don't have spec controller, request <br/> you can get scaffold code
            ```ruby
               rails generate rspec:scaffold post
            ```
            ```ruby
               # spec/controllers/posts_controller_spec.rb
               require 'rails_helper'
               
               RSpec.describe PostsController, type: :controller do
                 include ApiHelper
               
                 # This should return the minimal set of attributes required to create a valid
                 # Post. As you add validations to Post, be sure to
                 # adjust the attributes here as well.
                 let(:user){
                   create(:user)
                 }
               
                 # let(:post){
                 #   create(:post)
                 # }
               
                 let(:posts) {
                   create_list(:post, 20)
                 }
               
                 let(:valid_attributes) {
                   {body: "sample body", user_id: user.id}
                 }
               
                 let(:invalid_attributes) {
                   {body: "", user_id: user.id}
                 }
               
                 # This should return the minimal set of values that should be in the session
                 # in order to pass any filters (e.g. authentication) defined in
                 # PostsController. Be sure to keep this updated too.
                 let(:valid_session) { {} }
               
                 describe "GET #index" do
                   it "returns a success response" do
                     authenticated_header(request: request, user: user)
                     get :index, params: {}, session: valid_session
                     expect(response).to be_successful
                   end
                 end
               
                 describe "GET #show" do
                   it "returns a success response" do
                     post = Post.create! valid_attributes
                     authenticated_header(request: request, user: user)
                     get :show, params: {id: post.to_param}, session: valid_session
                     expect(response).to be_successful
                   end
                 end
               
                 describe "POST #create" do
                   context "with valid params" do
                     it "creates a new Post" do
                       authenticated_header(user: user, request: request)
                       expect {
                         post :create, params: {post: valid_attributes}, session: valid_session
                       }.to change(Post, :count).by(1)
                     end
               
                     it "renders a JSON response with the new post" do
                       authenticated_header(user: user, request: request)
                       post :create, params: {post: valid_attributes}, session: valid_session
                       expect(response).to have_http_status(:created)
                       expect(response.content_type).to include('application/json')
                       expect(response.location).to eq(post_url(Post.last))
                     end
                   end
               
                   context "with invalid params" do
                     it "renders a JSON response with errors for the new post" do
                       authenticated_header(user: user, request: request)
                       post :create, params: {post: invalid_attributes}, session: valid_session
                       expect(response).to have_http_status(:unprocessable_entity)
                       expect(response.content_type).to include('application/json')
                     end
                   end
                 end
               
                 describe "PUT #update" do
                   context "with valid params" do
                     let(:new_attributes) {
                       {body: "sample body 222", user_id: user.id}
                     }
               
                     it "updates the requested post" do
                       post = Post.create! valid_attributes
                       authenticated_header(user: user, request: request)
                       put :update, params: {id: post.to_param, post: new_attributes}, session: valid_session
                       post.reload
                       expect(post.body).to eq(new_attributes[:body])
                     end
               
                     it "renders a JSON response with the post" do
                       post = Post.create! valid_attributes
                       authenticated_header(user: user, request: request)
                       put :update, params: {id: post.to_param, post: valid_attributes}, session: valid_session
                       expect(response).to have_http_status(:ok)
                       expect(response.content_type).to include('application/json')
                     end
                   end
               
                   context "with invalid params" do
                     it "renders a JSON response with errors for the post" do
                       post = Post.create! valid_attributes
                       authenticated_header(user: user, request: request)
                       put :update, params: {id: post.to_param, post: invalid_attributes}, session: valid_session
                       expect(response).to have_http_status(:unprocessable_entity)
                       expect(response.content_type).to include('application/json')
                     end
                   end
               
                   context "with invalid Authorize" do
                     let(:another_user){
                       create(:user)
                     }
                     it "renders a JSON response with errors (http code 403, Forbidden) for the post" do
                       post = Post.create! valid_attributes
                       authenticated_header(user: another_user, request: request)
                       put :update, params: {id: post.to_param, post: invalid_attributes}, session: valid_session
                       expect(response).to have_http_status(:forbidden)
                       expect(response.content_type).to include('application/json')
                     end
                   end
                 end
               
                 describe "DELETE #destroy" do
                   it "destroys the requested post" do
                     post = Post.create! valid_attributes
                     authenticated_header(user: user, request: request)
                     expect {
                       delete :destroy, params: {id: post.to_param}, session: valid_session
                     }.to change(Post, :count).by(-1)
                   end
                 end
               
               end
    
            ```
    3. Run
        ```ruby
             $ rake db:test:prepare
             $ bundle exec rspec --format documentation

                AuthenticationController
                  POST #login
                    with valid email, password
                      Login Success
                    with invalid params
                      Login Fails
                      Login Fails with wrong email
                      Login Fails with wrong password

                CommentsController
                  GET #index
                    returns a success response
                  GET #show
                    returns a success response
                  POST #create
                    with valid params
                      creates a new Comment
                      renders a JSON response with the new comment
                    with invalid params
                      renders a JSON response with errors for the new comment
                  PUT #update
                    with valid params
                      updates the requested comment
                      renders a JSON response with the comment
                    with invalid params
                      renders a JSON response with errors for the comment
                    with invalid Authorize
                      renders a JSON response with errors (http code 403, Forbidden) for the post
                  DELETE #destroy
                    destroys the requested comment

                PostsController
                  GET #index
                    returns a success response
                  GET #show
                    returns a success response
                  POST #create
                    with valid params
                      creates a new Post
                      renders a JSON response with the new post
                    with invalid params
                      renders a JSON response with errors for the new post
                  PUT #update
                    with valid params
                      updates the requested post
                      renders a JSON response with the post
                    with invalid params
                      renders a JSON response with errors for the post
                    with invalid Authorize
                      renders a JSON response with errors (http code 403, Forbidden) for the post
                  DELETE #destroy
                    destroys the requested post

                UsersController
                  GET #index
                    returns a success response
                  GET #show
                    returns a success response
                  POST #create
                    with valid params
                      creates a new User
                      renders a JSON response with the new user
                    with invalid params
                      renders a JSON response with errors for the new user
                  PUT #update
                    with valid params
                      updates the requested user
                      renders a JSON response with the user
                    with invalid params
                      renders a JSON response with errors for the user
                  DELETE #destroy
                    destroys the requested user

                Posts
                  GET /posts
                    works! (now write some real specs)

                AuthenticationController
                  routing
                    routes to #login

                CommentsController
                  routing
                    routes to #index
                    routes to #show
                    routes to #create
                    routes to #update via PUT
                    routes to #update via PATCH
                    routes to #destroy

                PostsController
                  routing
                    routes to #index
                    routes to #show
                    routes to #create
                    routes to #update via PUT
                    routes to #update via PATCH
                    routes to #destroy

                UsersController
                  routing
                    routes to #index
                    routes to #show
                    routes to #create
                    routes to #update via PUT
                    routes to #update via PATCH
                    routes to #destroy

                Finished in 1.76 seconds (files took 1.65 seconds to load)
                53 examples, 0 failures
        ```
