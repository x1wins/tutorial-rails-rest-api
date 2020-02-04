# tutorial-rails-rest-api

How to Run
----------

1. Ready to database
    1. Run Postgresql and migrate
        ```bash
            bundle install
        ````
        ```bash
            rake docker:db:init
            rake docker:db:run
        ```
        ```bash
            rake db:migrate
            rake db:migrate RAILS_ENV=test
        ````
        ```bash
            rake db:seed
        ```
    2. Run Redis for cache
       ```bash
           docker run --rm --name my-redis-container -p 7001:6379 -d redis redis-server --appendonly yes
           redis-cli -h localhost -p 7001
       ```
2. ELK
    ```bash
        git clone https://github.com/deviantony/docker-elk
        cd docker-elk
        docker-compose exec -T elasticsearch bin/elasticsearch-setup-passwords auto --batch
        # https://github.com/deviantony/docker-elk#setting-up-user-authentication
        docker-compose up --build
    ```
3. Testing
    ```bash
        bundle exec rpsec --format documentation
    ```
4. Rails Server Run
    ```bash
        rails s
    ```
5. Swagger - Restful Api Documentation
    ```bash
        rake rswag 
    ``` 
    > http://localhost:3000/api-docs/index.html

TODO
----
- [x] Generate porject ```rails new [Project Name] --api -T -d postgresql```
- [x] Database setting Gem https://github.com/x1wins/docker-postgres-rails
- [x] User scaffold
    - [x] User scaffold and JWT for user authenticate Gem https://github.com/x1wins/jwt-rails
    - [x] User role http://railscasts.com/episodes/189-embedded-association?view=asciicast https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
- [x] Category scaffold
- [x] Post scaffold
- [x] Comment scaffold
- [x] Model Serializer https://itnext.io/a-quickstart-guide-to-using-serializer-with-your-ruby-on-rails-api-d5052dea52c5
- [x] Rspec https://relishapp.com/rspec/rspec-rails/docs/gettingstarted
- [x] Swager https://github.com/rswag/rswag
- [x] Add published condition of association https://www.rubydoc.info/gems/active_model_serializers/0.9.4
- [x] Search in posts
- [ ] Pagination https://github.com/kaminari/kaminari
  - [x] categories#index
  - [x] posts#index
  - [x] posts#index Comments
  - [x] posts#show Comments
  - [x] Add json of pagination
- [x] Parent Model 404 check in Nested Model
  - [x] Parent Category in Post#index 404 check
    - [x] Post rspec
  - [x] Parent Post, Category in Comment#index 404 check
    - [x] Comment rspec
- [ ] N+1
- [ ] log
  - [ ] model tracking https://github.com/paper-trail-gem/paper_trail 
  - [x] ELK https://github.com/deviantony/docker-elk
- [x] Versioning http://railscasts.com/episodes/350-rest-api-versioning?view=asciicast

How what to do
--------------
* [Build Json with active_model_serializers Gem](#build-json-with-active_model_serializers-gem) 
* [Nested Model](#nested-model)
* [add published](#add-published)
* [Category](#category)
* [Testing](#testing)
    * [Facker gem](#facker-gem)
    * [CURL](#curl)
    * [Unit Testing with Rspec](/unit_testing_with_rspec.md)
* [rswag for API Documentation](#rswag-for-api-documentation)
* [Codegen](#codegen)
* [Log For ELK stack (Elastic Search, Logstash, Kibana)](#log-for-elk-stack-elastic-search-logstash-kibana)
    * [lograge.rb with custom config](#logragerb-with-custom-config)
    * [ELK Setup](/rails_log_with_elk_setup.md)
* [Redis](#redis)    
    * [server run](#server-run)    
    * [add gem](#add-gem)    
    * [config](#config)    
    * [how to added cache](#how-to-added-cache)    

### Build Json with active_model_serializers Gem
1. Gemfile
    ```bash
      gem 'active_model_serializers'
    ```
2. Generate Serializer
    1. Generate Serializer to Exist Model user, post
        ```bash
          rails g serializer user name:string username:string email:string
          rails g serializer post body:string user:references published:boolean
        ```
    2. Generate Serializer New Model comment
        ```bash
          rails g scaffold comment body:string post:references user:references published:boolean
          rails g serializer comment body:string user:references published:boolean
        ```
3. Add Model Attribute
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
      
### Nested Model        
1. Comment Controller
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
2. Model
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
    
### add published
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
2. Add ```published = true``` condition for has_many In Model Serializer
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
        
### Category
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

### Testing
#### Facker gem

> https://rubyinrails.com/2018/11/10/rails-building-json-api-resopnses-with-jbuilder/

    ```ruby
        gem 'faker', '~> 1.9.1', group: [:development, :test]
    ```

#### CURL
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
6. loop curl
    ```bash
        for i in {1..100}; do bundle exec rspec; done
        for i in {1..10000}; do curl -X GET "http://localhost:3000/categories?page=1" -H "accept: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODA1NzY5NDZ9.vjoQpeOKdX83JwAwkPBi6p-dWjc1MPGVUQsSG9QSWhg"; done
        ab -n 10000 -c 100 -H "accept: application/json" -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODA1NzY5NDZ9.vjoQpeOKdX83JwAwkPBi6p-dWjc1MPGVUQsSG9QSWhg" -v 2 http://localhost:3000/categories?page=1
    ```
    > if you want stop for loop
    ```bash
        pkill rspec
    ```
    > login sample curl
    ```bash
        curl -w "\n" -X POST "http://localhost:3000/auth/login" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"email\": \"hello@changwoo.org\", \"password\": \"hello1234\"}" >> curl.log
    ```

#### [Unit Testing with Rspec](/unit_testing_with_rspec.md)

### rswag for API Documentation
1. testing
    ``` bundle exec rspec spec/requests/users_spec.rb --format documentation ```
2. Generate documentation

    > this command ```rake rswag ``` will generate swag documentation. 
    > then you can connect to
    > http://localhost:3000/api-docs/index.html
    
    ![swagger_screencapture](/localhost-3000-api-docs-index-html.png)
    
### Codegen
    > We developed server side code and We shoud need Client code. you can use Swagger-Codegen https://github.com/swagger-api/swagger-codegen#swagger-code-generator
    ```bash
        brew install swagger-codegen
        swagger-codegen generate -i http://localhost:3000/api-docs/v1/swagger.yaml -l swift5 -o ./swift 
    ```        
    
### Log For ELK stack (Elastic Search, Logstash, Kibana)

#### lograge.rb with custom config
https://github.com/roidrage/lograge
https://ericlondon.com/2017/01/26/integrate-rails-logs-with-elasticsearch-logstash-kibana-in-docker-compose.html
[lograge.rb](/config/lograge.rb) <br/>
[elk.yml](/config/elk.yml) <br/>
[application.rb](/config/application.rb) https://guides.rubyonrails.org/v4.2/configuring.html#custom-configuration
> override append_info_to_payload for lograge, append_info_to_payload method put parameter to payload[]
```ruby
        class ApplicationController < ActionController::API
          #...leave out the details
        
          def append_info_to_payload(payload)
            super
            payload[:ip] = remote_ip(request)
            if @current_user.present?
              begin
                user = User.find(@current_user.id)
                payload[:email] = user.email
                payload[:user_id] = user.id
              rescue ActiveRecord::RecordNotFound => e
                payload[:email] = ''
                payload[:user_id] = ''
              end
            end
          end
        
          def remote_ip(request)
            request.headers['HTTP_X_REAL_IP'] || request.remote_ip
          end
        end
```
         
#### [ELK Setup](/rails_log_with_elk_setup.md)

### Redis
#### server run
```bash
docker run --rm --name my-redis-container -p 7001:6379 -d redis redis-server --appendonly yes
redis-cli -h localhost -p 7001
```

#### add gem
```ruby
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'
```

#### config
```ruby
# config/initializers/redis.rb

$redis = Redis::Namespace.new("tutorial_post", :redis => Redis.new(:host => '127.0.0.1', :port => 7001))

```

#### how to added cache
```ruby
  # GET /categories
  def index
    page = params[:page].present? ? params[:page] : 1
    per = params[:per].present? ? params[:per] : 10
    pagaination_param = {
        category_page: page,
        category_per: per,
        post_page: @post_page,
        post_per: @post_per
    }
    @categories = fetch_categories pagaination_param
    render json: @categories
  end
```

```ruby
    class Category < ApplicationRecord
      include CategoryHelper
      ...your code
      after_save :clear_cache
    end
```

```ruby
    # app/helpers/category_helper.rb
    module CategoryHelper
      def fetch_categories pagaination_param
        page = pagaination_param[:category_page]
        per = pagaination_param[:category_per]
        key = "categories"+pagaination_param.to_s
        categories =  $redis.get(key)
        if categories.nil?
          @categories = Category.published.by_date.page(page).per(per)
          categories = Pagination.build_json(@categories, pagaination_param).to_json
          $redis.set(key, categories)
          $redis.expire(key, 1.hour.to_i)
        end
        categories
      end
      def clear_cache
        keys = $redis.keys "*categories*"
        keys.each {|key| $redis.del key}
      end
    end
```