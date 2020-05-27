[![Build Status](https://travis-ci.com/x1wins/tutorial-rails-rest-api.svg?branch=master)](https://travis-ci.com/x1wins/tutorial-rails-rest-api)
[![Heroku](http://heroku-badge.herokuapp.com/?app=tutorial-rails-rest-api&root=api-docs/index.html)](https://tutorial-rails-rest-api.herokuapp.com/api-docs/index.html)
[![Inline docs](http://inch-ci.org/github/x1wins/tutorial-rails-rest-api.svg?branch=master)](http://inch-ci.org/github/x1wins/tutorial-rails-rest-api)
[![HitCount](http://hits.dwyl.com/x1wins/tutorial-rails-rest-api.svg)](http://hits.dwyl.com/x1wins/tutorial-rails-rest-api)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)
[![Known Vulnerabilities](https://snyk.io/test/github/x1wins/tutorial-rails-rest-api/badge.svg)](https://snyk.io/test/github/x1wins/tutorial-rails-rest-api)



# Tutorial rails rest api
We always need rest api server with json response for client.<br/>
I try developing best practice **Restful Api** with rails or another framework. This tutorial use **Ruby on Rails** [Api-only Applications](https://guides.rubyonrails.org/api_app.html).<br/>
I hope no one more suffer from many developing methods such a **Unit testing with Rspec**, **Token base Authenticate and Authorized**, **Api Documentation**, **Storage config for upload**, **Log collecting** .. etc<br/>

# Index
* [Demo](#Demo)
    * [https://tutorial-rails-rest-api.herokuapp.com/api-docs/index.html](https://tutorial-rails-rest-api.herokuapp.com/api-docs/index.html)
* [Feature](#Feature)
* [Prerequisites](#Prerequisites)
* [How to Install and Run **Tutorial rails rest api Project** in your local](#How-to-Install-and-Run-Tutorial-rails-rest-api-Project-in-your-local)
* [Deploy on Production server](#Deploy-on-Production-server)
* [TODO](#TODO)
* [Tutorial Index - Rails rest api for post](#Tutorial-index---rails-rest-api-for-post)
    * [Storage config for Upoload](#Storage-config-for-Upoload)
    * [Authentication](#Authentication)
    * [Authorize](#Authorize)
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
        * [elk.yml config](#elkyml-config)
        * [lograge.rb with custom config](#logragerb-with-custom-config)
        * [ELK Setup](/rails_log_with_elk_setup.md)
    * [Redis](#redis)    
        * [server run](#server-run)    
        * [add gem](#add-gem)    
        * [config](#config)
        * [how to added cache](#how-to-added-cache)    
        * [docker-compose.yml config](/docker-compose.yml)
        * [redis.rb](/config/initializers/redis.rb)
        * [redis.yml](/config/redis.yml)
    * [Active Storage](#active-storage)
        * [Setup](#setup)  
    * Postgresql
        * [docker-compose.yml config](/docker-compose.yml)
        * [database.yml](/config/database.yml)      

## Feature
* supported Unit Testing with [Rspec](#Testing-with-rspec)
* supported Document with Rswag ```gem 'rswag-api'``` ```gem 'rswag-ui'``` ```gem 'rswag-specs'```https://github.com/rswag/rswag
* supported Docker-compose
* supported [Heroku](#Deploy-on-Production-server) [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
* supported [ELK](#log-for-elk-stack-elastic-search-logstash-kibana) for logs with ```gem 'lograge'```
* used Ruby:2.6.0 with [Dockerfile](/Dockerfile)
* used Rails 6
* used Active Storage for Upload file with Cloudiry free plan [(**Required config key**)](#Cloudinary)
* used ```gem 'active_model_serializers'``` for json response
* used ```gem 'jwt-rails', '~> 0.0.1'``` for token based [Authentication](#Authentication), [Authorize](#Authorize)
* used ```gem 'kaminari'``` for pagination
* used [postgresql](/docker-compose.yml) with Active record
* used [redis](/docker-compose.yml) for cache
* used https://app.snyk.io/ for security

## Prerequisites
> Default storage config is Cloudinary. but i did not push master.key<br/>
**you have to generate [**master.key**](#Changing-masterkey)** and add your storage config
1. #### Changing master.key
    1. Delete old master.key and credentials.yml.enc https://www.chrisblunt.com/rails-on-docker-rails-encrypted-secrets-with-docker/
        ```bash
            $ rm config/master.key config/credentials.yml.enc
        ```
    2. create new master.key and credentials.yml.enc
        * docker-compose
            ```bash
                $ docker-compose run --rm -e EDITOR=vim web bin/rails credentials:edit
            ```
        * Non docker-compose
            ```bash
                $ EDITOR=vim web bin/rails credentials:edit   
            ```
        * result
            ```bash
                Adding config/master.key to store the encryption key: c7713a458177982b0d951fd50649b674
                
                Save this in a password manager your team can access.
                
                If you lose the key, no one, including you, can access anything encrypted with it.
                
                      create  config/master.key
                
                File encrypted and saved.
            ```
2. #### Clodinary config
    > open ```EDITOR=vim rails credentials:edit``` or ```docker-compose run --rm -e EDITOR=vim web bin/rails credentials:edit```
    * you can join free plan [Cloudinary](https://cloudinary.com) and get PROJECT_NAME, API_KEY, API_SECRET
    ```yaml
        cloudinary:
          cloud_name: PROJECT_NAME
          api_key: API_KEY
          api_secret: API_SECRET
    ```
    
## How to Install and Run Tutorial rails rest api Project in your local
* You can choice for run with ```docker-compose``` or ```Non docker-compose```. You shold better use ```docker-compose```
    * download from github
        ```bash
            git clone https://github.com/x1wins/tutorial-rails-rest-api.git
        ```
    * ### docker-compose
        1. Build and Run with Background demon
            ```bash
                docker-compose up --build -d
            ```
        2. Database Setup
            ````bash
                docker-compose run web bundle exec rake db:test:load && \
                docker-compose run web bundle exec rake db:migrate && \
                docker-compose run web bundle exec rake db:seed --trace
            ````
        3. Another docker-compose Command for ```rails``` and ```rake```
            * How do I update Gemfile.lock on my Docker host?
                https://stackoverflow.com/a/37927979/1399891
                ```bash
                    docker-compose run --no-deps web bundle
                ```
            * Database Reset
                ```bash
                    docker-compose run web bundle exec rake db:reset --trace
                ```
            * Log 
                * Development enviroment
                    ```bash
                        tail -f log/development.log # if you wanna show sql log
                    ```
                * Production enviroment
                    ```bash
                        tail -f log/production.log 
                    ```
            * #### Testing with rspec
                ```bash
                    docker-compose run --no-deps web bundle exec rspec --format documentation
                    docker-compose run --no-deps web bundle exec rspec --format documentation spec/requests/api/v1/upload_spec.rb
                    docker-compose run --no-deps web bundle exec rspec --format documentation spec/requests/api/v1/posts_spec.rb
                    docker-compose run --no-deps web bundle exec rspec --format documentation spec/controllers/api/v1/posts_controller_spec.rb
                ```
            * Rswag for documentation ```http://localhost:3000/api-docs/index.html```
                ```bash
                    docker-compose run --no-deps web bundle exec rake rswag
                ```
            * rails console
                ```bash
                    docker-compose exec web bin/rails c
                ```
            * routes
                ```bash
                    docker-compose run --no-deps web bundle exec rake routes
                ```
    * ### Non docker-compose
        1. bundle
           ```bash
               bundle install
           ```
        2. postgresql run
           ```bash
               rake docker:pg:init
               rake docker:pg:run
           ```
        3. migrate
           ```bash
               rake db:migrate RAILS_ENV=test
               rake db:migrate
               rake db:seed
           ```
        4. redis run
           ```bash
              docker run --rm --name my-redis-container -p 6379:6379 -d redis redis-server --appendonly yes
              redis-cli -h localhost -p 7001
           ```
        5. server run
           ```bash
               rails s
           ```
        6. Another Command for ```rails``` and ```rake```
            * Database Reset
                ```bash
                    rake db:reset --trace
                ```
            * Log 
                * Development enviroment
                    ```bash
                        tail -f log/development.log # if you wanna show sql log
                    ```
                * Production enviroment
                    ```bash
                        tail -f log/production.log 
                    ```
            * Testing
               ```bash
                   bundle exec rspec --format documentation
                   bundle exec rspec --format documentation spec/requests/api/v1/upload_spec.rb
                   bundle exec rspec --format documentation spec/requests/api/v1/posts_spec.rb
                   bundle exec rspec --format documentation spec/controllers/api/v1/posts_controller_spec.rb
               ```
            * Rswag for documentation ```http://localhost:3000/api-docs/index.html```
                ```bash
                   rake rswag 
                ```
            * rails console
                ```bash
                    rails c
                ```
            * routes
                ```bash
                    rake routes
                ```


# Deploy on Production server
> i did deploy to heroku. let's break it down with swagger UI <br/>
https://tutorial-rails-rest-api.herokuapp.com/api-docs/index.html <br/>
there will be auto added ```Heroku Redis free plan add-on```, ```Heroku Postgresql free plan add-on```, ```Cloudinary free plan add-on```
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
* Heroku
    1. install CLI https://devcenter.heroku.com/articles/heroku-cli#download-and-install
        ```bash
            brew tap heroku/brew && brew install heroku
        ```
    2. Login heroku
        > https://dashboard.heroku.com/apps/YOUR_PORJECT_NAME/deploy/heroku-git
        ```bash
            heroku login
            heroku git:clone -a YOUR_PORJECT_NAME
            cd YOUR_PORJECT_NAME
        ```
    3. migration
        > [/db/seeds/development.rb](/db/seeds/development.rb)
        > [/db/seeds/production.rb](/db/seeds/production.rb)
        ```bash
            heroku rake db:migrate --app YOUR_PORJECT_NAME
            heroku rake db:seed --app YOUR_PORJECT_NAME
        ```
    4. Another cmd        
        1. master.key
            ```bash
                heroku config:set RAILS_MASTER_KEY=asdf1234 --app YOUR_PORJECT_NAME
            ```
        2. restart
            ```bash
                heroku restart --app YOUR_PORJECT_NAME
            ```
        3. log
            ```bash
                heroku logs --tail --app YOUR_PORJECT_NAME
            ```
        4. console with heroku
            ```bash
                heroku run rails console --app YOUR_PORJECT_NAME
            ```
* Docker compose in your server
    1. ssh
        ```bash
            ssh -i ~/your.pem ec2-user@ec2-your-code.compute.amazonaws.com
        ```
    1. install git, docker with yum on aws ec2 instance https://www.changwoo.org/x1wins@changwoo.net/2019-09-19/aws-setting-with-docker-git-cfac5c7d1b 
        ```bash
            sudo yum update -y
            sudo yum install docker
            sudo service docker start
            sudo usermod -a -G docker ec2-user
            sudo yum install git
        ```
    2. git clone
        ```bash
            git clone https://github.com/x1wins/tutorial-rails-rest-api.git
            cd tutorial-rails-rest-api/
        ```
    3. [change **master.key**](#Changing-masterkey)
    4. [docker-compose](#docker-compose)

TODO
----
- [x] Generate porject ```rails new [Project Name] --api -T -d postgresql```
- [x] Database setting Gem https://github.com/x1wins/docker-postgres-rails
- [x] User scaffold
    - [x] User scaffold and JWT for user authenticate Gem https://github.com/x1wins/jwt-rails
    - [x] User role http://railscasts.com/episodes/189-embedded-association?view=asciicast https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
    - [x] avatar file upload
    - [ ] generate uninque username https://alexcastano.com/generate-unique-usernames-for-ruby-on-rails/
- [x] Category scaffold
    - [x] fix post.category serialize
- [x] Post scaffold
    - [x] add title column
- [x] Comment scaffold
    - [ ] add depth
    - [ ] file upload
- [x] Model Serializer https://itnext.io/a-quickstart-guide-to-using-serializer-with-your-ruby-on-rails-api-d5052dea52c5
- [x] Rspec https://relishapp.com/rspec/rspec-rails/docs/gettingstarted
- [x] Swager https://github.com/rswag/rswag
- [x] Add published condition of association https://www.rubydoc.info/gems/active_model_serializers/0.9.4
- [x] Search in posts
- [x] Pagination https://github.com/kaminari/kaminari
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
- [x] File upload to Local path with active storage 
    - [x] create or add attached file
    - [x] delete
- [ ] docker-compose
    - [ ] staging
    - [ ] production
    
## Tutorial Index - Rails rest api for post
    
### Storage config for Upoload
> you can change **active storage** config to such a like ***cloud storage*** ```S3 or GCS``` in [storage.yml](/config/storage.yml)
>> if you use heroku and you upload file on local path of Ephemeral Disk. Uploaded file will be gone in a few minutes because heroku hard drive is [Ephemeral Disk](https://devcenter.heroku.com/articles/active-storage-on-heroku#ephemeral-disk)
* Local
    * Add ```~/storage``` path for saving uploaded file
        ```bash
            mkdir ~/storage
        ```
    * Update ```config.active_storage.service = :local``` in [development.rb](/config/environments/development.rb), [production.rb](/config/environments/production.rb)
    * Added local config in [storage.yml](/config/storage.yml)
* #### Cloudinary
    * https://cloudinary.com/documentation/rails_activestorage
    * https://github.com/0sc/activestorage-cloudinary-service
    * Added api key 
        1. Add gemfile
            ```bash
                gem 'cloudinary'
                gem 'activestorage-cloudinary-service'
            ```
        2. open ```config/storage.yml```
            ```yaml
                cloudinary:
                  service: Cloudinary
                  cloud_name: <%= Rails.application.credentials.dig(:cloudinary, :cloud_name) %>
                  api_key: <%= Rails.application.credentials.dig(:cloudinary, :api_key) %>
                  api_secret: <%= Rails.application.credentials.dig(:cloudinary, :api_secret) %>
            ```
        3. [Changing **master.key**](#Changing-masterkey)    
        4. [Clodinary config](#Clodinary-config)    


### Authentication
```ruby
    class ApplicationController < ActionController::API
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
          is_banned @current_user
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end
    end
    
    # How to Use
    class PostsController < ApplicationController
        before_action :authorize_request
    end
```

### Authorize
```ruby
    class ApplicationController < ActionController::API
      def is_owner user_id
        unless user_id == @current_user.id
          render json: nil, status: :forbidden
          return
        end
      end
    
      def is_owner_object data
        if data.nil? or data.user_id.nil?
          return render status: :not_found
        else
          is_owner data.user_id
        end
      end
    end
    
    # How to Use
    class PostsController < ApplicationController
        before_action only: [:update, :destroy, :destroy_attached] do
          is_owner_object @post ##your object
        end
    end        
```   

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
5. Pagination with serializer

[/app/helpers/category_helper.rb](/app/helpers/category_helper.rb)

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
  def clear_cache_categories
    keys = $redis.keys "*categories*"
    keys.each {|key| $redis.del key}
  end
end

class CategoriesController < ApplicationController
      include CategoryHelper
      //... your code

      # GET /categories
      def index
        page = params[:page].presence || 1
        per = params[:per].presence || Pagination.per
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
  belongs_to :user
  has_many :posts
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  validates :title, presence: true
  validates :body, presence: true
  after_save :clear_cache_categories
end
```    
```ruby
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :posts_pagination
  has_one :user
  has_many :posts
  def posts
    post_page = (instance_options.dig(:pagaination_param, :post_page).presence || 1).to_i
    post_per = (instance_options.dig(:pagaination_param, :post_per).presence || 0).to_i
    object.posts.published.by_date.page(post_page).per(post_per)
  end
  def posts_pagination
    post_per = (instance_options.dig(:pagaination_param, :post_per).presence || Pagination.per).to_i
    Pagination.build_json(posts)[:posts_pagination] if post_per > 0
  end
end
```    
```ruby
# /lib/pagination.rb
class Pagination
  def self.information array
    {
        current_page: array.current_page,
        next_page: array.next_page,
        prev_page: array.prev_page,
        total_pages: array.total_pages,
        total_count: array.total_count
    }
  end
  def self.build_json array, pagaination_param = {}
    ob_name = array.name.downcase.pluralize.to_sym
    json = Hash.new
    json[ob_name] = ActiveModelSerializers::SerializableResource.new(array.to_a, pagaination_param: pagaination_param)
    pagination_name = "#{ob_name}_pagination".to_sym
    json[pagination_name] = self.information array
    json
  end
end
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
            object.comments.where(published: true).order('id DESC')
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
### Post
1. add title column
```bash
    rails g migration AddTitleToPosts title:string
```


### model alter
1. remove column
```bash
    rails g migration RemoveColumnFromTables column:type
```
2. add column
```bash
    rails g migration AddColumnFromTables column:type
```
3. add unique to name
```bash
    rails g migration AddUniqueNameToUsers
```
> sample - add unique to user.name in generate file
```ruby
  add_index :table_name, :column_name, unique: true
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
    
    > file upload - create
    ```bash
        curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODE1MjgwNjd9.YKkk0B-T0_AROBTVaQ7f_OE2hnFGp1HcR2wbEDa9EtA" \
        -F "post[body]=string123" \
        -F "post[category_id]=1" \
        -F "post[files][]=@/Users/rhee/Desktop/item/log/47310817701116.csv" \
        -F "post[files][]=@/Users/rhee/Desktop/item/log/47310817701116.csv" \
        -X POST http://localhost:3000/api/v1/posts
    ```
    
    > file upload - delete
    ```bash
        curl -X DELETE "http://localhost:3000/api/v1/posts/731/attached/93" \
        -H  "accept: application/json" \
        -H  "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODE1NDY0Njl9.XjaDElIlvmWDyAWMiGtjZByax-IuG1HBn3i8-Rjl1EU"
    ```
    
    > file upload - update
    ```bash
        curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODE1MjgwNjd9.YKkk0B-T0_AROBTVaQ7f_OE2hnFGp1HcR2wbEDa9EtA" \
        -F "post[body]=aasadsadasdasstring123" \
        -F "post[files][]=@/Users/rhee/Desktop/item/log/47310817701116.csv" \
        -F "post[files][]=@/Users/rhee/Desktop/item/log/47310817701116.csv" \
        -X PUT http://localhost:3000/api/v1/posts/728
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

> https://github.com/swagger-api/swagger-codegen/wiki/FAQ#how-can-i-generate-an-android-sdk    
```bash
    brew install swagger-codegen
    mkdir -p /var/tmp/java/okhttp-gson/
    swagger-codegen generate -i http://localhost:3000/api-docs/v1/swagger.yaml \
      -l java --library=okhttp-gson \
      -D hideGenerationTimestamp=true \
      -o /var/tmp/java/okhttp-gson/  
```   

Caused by: android.os.NetworkOnMainThreadException
https://www.toptal.com/android/android-threading-all-you-need-to-know

sample
https://i.stack.imgur.com/ytin1.png
https://gist.github.com/just-kip/1376527af60c74b07bef7bd7f136ff56
```java
        AsyncTask<Post, Void, Post> asyncTask = new AsyncTask<Post, Void, Post>() {
            @Override
            protected Post doInBackground(Post... params) {
                try {
                    ApiClient defaultClient = Configuration.getDefaultApiClient();
                    String authorization = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODIwOTg3NzF9.JGPR2oOOeGcjSocU4Ohvw1bg49ZjTQ9tQ3FtxmqmPDM"; // String | JWT token for Authorization
                    ApiKeyAuth Bearer = (ApiKeyAuth) defaultClient.getAuthentication("Bearer");
                    Bearer.setApiKey(authorization);
                    PostApi apiInstance = new PostApi();
                    String id = "1"; // String | id
                    Integer commentPage = 1; // Integer | Page number for Comment
                    Integer commentPer = 10; // Integer | Per page number For Comment
                    Post result;
                    try {
                        result = apiInstance.apiV1PostsIdGet(id, authorization, commentPage, commentPer);
//                        System.out.println(result);
                    } catch (ApiException e) {
                        System.err.println("Exception when calling PostApi#apiV1PostsIdGet");
                        e.printStackTrace();
                        result = new Post();
                    }
                    return result;
                } catch (Exception e) {
                    e.printStackTrace();
                    return new Post();
                }
            }

            @Override
            protected void onPostExecute(Post post) {
                super.onPostExecute(post);
                if (post != null) {
                    mEmailView.setText(post.getBody());
                    System.out.print(post);
                }
            }
        };

        asyncTask.execute();
```

https://www.sitepoint.com/consuming-web-apis-in-android-with-okhttp/
<uses-permission android:name="android.permission.INTERNET"/>


No Network Security Config specified, using platform default
Use 10.0.2.2 to access your actual machine.
https://stackoverflow.com/questions/5528850/how-do-you-connect-localhost-in-the-android-emulator
//    private String basePath = "https://tutorial-rails-rest-api.herokuapp.com";
//    private String basePath = "http://localhost:3000";
    private String basePath = "http://10.0.2.2:3000";     
    
swagger-annotations Unable to pre-dex
https://stackoverflow.com/questions/43997544/execution-failed-for-task-java-lang-runtimeexceptionunable-to-pre-dex
```groovy
dexOptions {
    javaMaxHeapSize "2g" // set it to 4g will bring unable to start JavaVirtualMachine
    preDexLibraries = false
  }
```
    
### Log For ELK stack (Elastic Search, Logstash, Kibana)

#### elk.yml config
> enable value is ```false``` or ```true``` <br/> 
exmaple : ```enable: false```<br/>
[elk.yml](/config/elk.yml) <br/>

```yml
# config/elk.yml

default: &default
  enable: false
  protocal: udp
  host: localhost
  port: 5000

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```

#### lograge.rb with custom config
https://github.com/roidrage/lograge <br/>
https://ericlondon.com/2017/01/26/integrate-rails-logs-with-elasticsearch-logstash-kibana-in-docker-compose.html <br/>
[lograge.rb](/config/initializers/lograge.rb) <br/>
```ruby
    Rails.application.configure do
      enable = Rails.configuration.elk['enable']
      protocal = Rails.configuration.elk['protocal']
      host = Rails.configuration.elk['host']
      port = Rails.configuration.elk['port']
    
      if enable
        config.autoflush_log = true
        config.lograge.base_controller_class = 'ActionController::API'
        config.lograge.enabled = true
        config.lograge.formatter = Lograge::Formatters::Logstash.new
        config.lograge.logger = LogStashLogger.new(type: protocal, host: host, port: port, sync: true)
        config.lograge.custom_options = lambda do |event|
          exceptions = %w(controller action format id)
          {
              type: :rails,
              environment: Rails.env,
              remote_ip: event.payload[:ip],
              email: event.payload[:email],
              user_id: event.payload[:user_id],
              request: {
                  headers: event.payload[:headers],
                  params: event.payload[:params].except(*exceptions)
              }
          }
        end
      end
    
    end
```

[application.rb](/config/application.rb) https://guides.rubyonrails.org/v4.2/configuring.html#custom-configuration <br/>
> override append_info_to_payload for lograge, 
append_info_to_payload method put parameter to payload[]
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
docker run --rm --name my-redis-container -p 7001:6379 -d redis 
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
    page = params[:page].presence || 1
    per = params[:per].presence || Pagination.per
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
      after_save :clear_cache_categories
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
      def clear_cache_categories
        keys = $redis.keys "*categories*"
        keys.each {|key| $redis.del key}
      end
    end
```


### Active Storage
#### Setup
> https://cameronbothner.com/activestorage-beyond-rails-views/
https://edgeguides.rubyonrails.org/active_storage_overview.html  
https://edgeguides.rubyonrails.org/active_storage_overview.html#has-many-attached
    
```bash
    rails active_storage:install
    rake db:migrate
```

> storage.yml
you wiil make dir /storage with ```mkdir /storage```
```yml
    test:
      service: Disk
      root: /storage/test
    
    local:
      service: Disk
      root: /storage
```

> routes.rb
```ruby
    Rails.application.routes.draw do
      namespace :api do
        namespace :v1 do
          # your code will be here ...
          # DELETE /posts/attached/:attached_id
          delete '/posts/:id/attached/:attached_id', to: 'posts#destroy_attached'
        end
      end
    end
```

> posts_controller.rb  
```@post.files.attach(params[:post][:files]) if params.dig(:post, :files).present?```is null check and add files
```ruby
      # posts_controller
      # POST /posts
      def create
        @post = Post.new(post_params)
        @post.files.attach(params[:post][:files]) if params.dig(:post, :files).present?

        set_category @post.category_id

        if @post.save
          render json: @post, status: :created, location: api_v1_post_url(@post)
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        @post.files.attach(params[:post][:files]) if params.dig(:post, :files).present?
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/:id/attached/:id
      def destroy_attached
        attachment = ActiveStorage::Attachment.find(params[:attached_id])
        attachment.purge # or use purge_later
      end
```

> post.rb
```ruby
    class Post < ApplicationRecord
      # your code will be here ...
      has_many_attached :files
    end

```

```ruby
    class PostSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers
      attributes :id, :body, :files, :comments_pagination
      def files
        return unless object.files.attachments
        file_urls = object.files.map do |file|
          {
              id: file.id,
              url: rails_blob_url(file)
          }
        end
        file_urls
      end
      # your code will be here ...     
    end
```

# apache bench mark 
https://gist.github.com/kelvinn/6a1c51b8976acf25bd78
    ```bash
        ab -c 10 -n 10000 \
        -T application/json \
        -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1OTA0MzExOTN9.GtlH3xbINMNSKAU00np5njGtDWEcXXOHZ2zbjKsgr24" \
        http://localhost:3000/api/v1/posts?category_id=1&page=1    
    ```
  