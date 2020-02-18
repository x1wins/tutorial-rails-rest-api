require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  include ApiHelper

  path '/api/v1/posts' do

    get('list posts') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :category_id, in: :query, type: :integer, default: '1', description: 'Category Id'
      parameter name: :page, in: :query, type: :integer, default: '1', description: 'Page number'
      parameter name: :per, in: :query, type: :integer, description: 'Per page number'
      parameter name: :comment_page, in: :query, type: :integer, description: 'Page number for Comment'
      parameter name: :comment_per, in: :query, type: :integer, description: 'Per page number For Comment'
      parameter name: :search, in: :query, type: :string, description: 'Search Keyword'
      produces 'application/json'

      response(200, 'Search') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category){
          create(:category)
        }
        let(:category_id) { category.id }
        let(:page) { 1 }
        let(:per) { }
        let(:comment_page) { }
        let(:comment_per) { }
        let(:search) { 'hello' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(200, 'Post Pagination') do
        let(:total_count) { 12 }
        let(:category){
          create(:category)
        }
        let(:post_user){
          create(:user)
        }
        before do
          create_list(:post, total_count*2 , category: category, user: post_user)
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category_id) { category.id }
        let(:page) { 1 }
        let(:per) { total_count/2 }
        let(:comment_page) { }
        let(:comment_per) { }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it do
          posts = JSON.parse(response.body, {symbolize_names: true})[:posts]
          expect(posts.class).to be(Array)
          expect(posts.length()).to eql per
        end
        run_test!
      end

      response(200, 'Nested Comment Pagination') do
        let(:total_count) { 12 }
        let(:comment_count) { 15 }
        let(:category){
          create(:category)
        }
        let(:post_user){
          create(:user)
        }
        let(:comment_user){
          create(:user)
        }

        before do
          posts = create_list(:post, total_count*2 , category: category, user: post_user)
          posts.each {|post|
            create_list(:comment, comment_count , post: post, user: comment_user)
          }
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category_id) { category.id }
        let(:page) { 1 }
        let(:per) { total_count/2 }
        let(:comment_page) { 1 }
        let(:comment_per) { 10 }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it 'returns a included comments response' do
          posts = JSON.parse(response.body, {symbolize_names: true})[:posts]
          posts.each {|post|
            comments = post[:comments]
            expect(comments.class).to be(Array)
            expect(comments.length()).to eql comment_per
          }
        end
        run_test!
      end

      response(200, 'Successful') do
        schema '$ref' => '#/definitions/posts'
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category){
          create(:category)
        }
        let(:category_id) { category.id }
        let(:page) { }
        let(:per) { }
        let(:comment_page) { }
        let(:comment_per) { }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:Authorization) { "Bearer invalid token" }
        let(:category){
          create(:category)
        }
        let(:category_id) { category.id }
        let(:page) { }
        let(:per) { }
        let(:comment_page) { }
        let(:comment_per) { }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found Category') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category){
          create(:category, published: false)
        }
        let(:category_id) { category.id }
        let(:page) { }
        let(:per) { }
        let(:comment_page) { }
        let(:comment_per) { }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end
    end

    post('create post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :body, in: :body, required: true, schema: {'$ref' => '#/definitions/post_param' }
      produces 'application/json'
      response(201, 'Successful') do
        schema '$ref' => '#/definitions/post'
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {post: {title: build_post.title, body: build_post.body, category_id: build_post.category.id} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:body) { {post: {title: build_post.title, body: build_post.body, category_id: build_post.category.id} } }


        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found Category') do
        let(:build_post){
          build(:post)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category){
          create(:category, published: false)
        }
        let(:body) { {post: {title: build_post.title, body: build_post.body, category_id: category.id} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:user){
          create(:user)
        }
        let(:category){
          create(:category)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {post: {title: "", body: "", category_id: category.id} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}' do

    get('show post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :comment_page, in: :query, type: :integer, description: 'Page number for Comment'
      parameter name: :comment_per, in: :query, type: :integer, description: 'Per page number For Comment'
      produces 'application/json'
      response(200, 'Successful') do
        schema '$ref' => '#/definitions/post'
        let(:total_count) { 12 }
        let(:comment_count) { 15 }
        let(:category){
          create(:category)
        }
        let(:comment_user){
          create(:user)
        }
        let(:post){
          create(:post, category: category)
        }

        before do
          create_list(:comment, comment_count , post: post, user: comment_user)
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { post.id }
        let(:comment_page) { 1 }
        let(:comment_per) { 10 }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it 'returns a included comments response' do
          post = JSON.parse(response.body, {symbolize_names: true})
          comments = post[:comments]
          expect(comments.class).to be(Array)
          expect(comments.length()).to eql comment_per
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:post){
          create(:post)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:id) { post.id }
        let(:comment_page) { }
        let(:comment_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found') do
        let(:user){
          create(:user)
        }
        let(:invalid_post_id){
          1
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { invalid_post_id }
        let(:comment_page) { }
        let(:comment_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found Category') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category){
          create(:category, published: false)
        }
        let(:post){
          create(:post, category: category)
        }
        let(:id) { post.id }
        let(:comment_page) { }
        let(:comment_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              post: {
                  type: :object,
                  properties: {
                      title: { type: :string },
                      body: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'

      response(200, 'Successful - update after multuplart file upload') do
        let(:uploadfile){
          Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.txt"))
        }
        let(:post){
          create(:post, files: [ uploadfile ])
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:body) { {post: {title: build_post.title, body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(200, 'Successful') do
        schema '$ref' => '#/definitions/post'
        let(:post){
          create(:post)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:body) { {post: {title: build_post.title, body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:post){
          create(:post)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:id) { post.id }
        let(:body) { {post: {title: build_post.title, body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:post){
          create(:post)
        }
        let(:build_post){
          build(:post)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { post.id }
        let(:body) { {post: {title: build_post.title, body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found Category') do
        let(:category){
          create(:category, published: false)
        }
        let(:post){
          create(:post, category: category)
        }
        let(:build_post){
          build(:post)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:body) { {post: {title: build_post.title, body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

    end

    delete('delete post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(204, 'Successful') do
        let(:post){
          create(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }

        run_test!
      end

      response(401, 'Unauthorized') do
        let(:post){
          create(:post)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:id) { post.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:post){
          create(:post)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { post.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found Category') do
        let(:category){
          create(:category, published: false)
        }
        let(:post){
          create(:post, category: category)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

end
