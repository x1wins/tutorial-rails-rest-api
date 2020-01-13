# tutorial-rails-rest-api

TODO
----
- [x] Generate porject ```rails new [Project Name] --api -T -d postgresql```
- [x] Database setting Gem https://github.com/x1wins/docker-postgres-rails
- [ ] User scaffold
    - [x] User scaffold and JWT for user authenticate Gem https://github.com/x1wins/jwt-rails
    - [ ] User role
- [x] Category scaffold
- [x] Post scaffold
- [x] Comment scaffold
- [x] Model Serializer https://itnext.io/a-quickstart-guide-to-using-serializer-with-your-ruby-on-rails-api-d5052dea52c5
- [x] Rspec https://relishapp.com/rspec/rspec-rails/docs/gettingstarted
- [x] Swager https://github.com/rswag/rswag
- [x] Add published condition of association https://www.rubydoc.info/gems/active_model_serializers/0.9.4
- [x] Search in posts
- [ ] Pagination https://github.com/kaminari/kaminari
  - [x] posts#index
  - [ ] posts#index Comments
  - [ ] posts#show Comments
- [ ] N+1
- [ ] log
  - [ ] model tracking https://github.com/paper-trail-gem/paper_trail 
  - [ ] ELK https://github.com/deviantony/docker-elk
  
  
  

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

7. [Unit Testing with Rspec](/unit_testing_with_rspec.md)

8. rswag

    1. testing
    
        ``` bundle exec rspec spec/requests/users_spec.rb --format documentation ```
    2. Generate documentation
    
        > this command ```rake rswag ``` will generate swag documentation. 
        > then you can connect to
        
        http://localhost:3000/api-docs/index.html
        
        ![swagger_screencapture](/localhost-3000-api-docs-index-html.png)
        
9. add published
    1. alter column

        ```bash
           $ rails generate migration ChangePublishedDefaultToComments published:boolean
        ```
        ```ruby
            class ChangePublishedDefaultToComments < ActiveRecord::Migration[6.0]
              def change
                change_column :comments, :published, :boolean, default: true
              end
            end
        ```
        
    2. Add published = true condition for has_many In Model Serializer

        ```ruby
            class PostSerializer < ActiveModel::Serializer
              attributes :id, :body
              has_one :user
              has_many :comments
              def comments
                object.comments.where(published: true).order('created_at DESC, id DESC')
              end
            end
        ```
        
10. Category
    1. generate
        ```bash
            rails g scaffold category title:string body:string user:references published:boolean
        ```        
    2. add referer
        ```bash
            rails g migration AddCategoryToPosts category:references
        ```
    3. migration
        ```ruby
             # db/seed.rb
             user = User.create!({username: 'hello', email: 'sample@changwoo.net', password: 'hhhhhhhhh', password_confirmation: 'hhhhhhhhh'})
             category = Category.create!({title: 'all', body: 'you can talk everything', user_id: user.id})
             posts = Post.where(category_id: nil).or(Post.where(published: nil))
             posts.each do |post|
               post.category_id = category.id
               post.published = true
               post.save
               p post
             end
             p category
        ```
        ```bash
            rake db:seed
        ```
11. Codegen
    > We developed server side code and We shoud need Client code. you can use Swagger-Codegen https://github.com/swagger-api/swagger-codegen#swagger-code-generator
    ```bash
        brew install swagger-codegen
        swagger-codegen generate -i http://localhost:3000/api-docs/v1/swagger.yaml -l swift5 -o ./swift 
    ```        