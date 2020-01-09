require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  include ApiHelper

  path '/posts' do

    get('list posts') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :category_id, in: :query, type: :integer, default: '1', description: 'Category Id'
      parameter name: :page, in: :query, type: :integer, default: '1', description: 'Page number'
      parameter name: :per, in: :query, type: :integer, description: 'Per page number'
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
        let(:search) { 'hello' }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(200, 'Pagination') do
        let(:total_count) { 50 }
        let(:category){
          create(:category)
        }
        before do
          create_list(:post, total_count*2 , category: category)
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category_id) { category.id }
        let(:page) { 1 }
        let(:per) { total_count }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it do
          posts = JSON.parse(response.body)
          expect(posts.class).to be(Array)
          expect(posts.length()).to eql total_count
        end
        run_test!
      end

      response(200, 'Successful') do
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
        let(:search) { }

        after do |example|
          p category
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
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              post: {
                  type: :object,
                  properties: {
                      body: { type: :string },
                      category_id: { type: :integer }
                  }
              }
          }
      }
      produces 'application/json'
      response(201, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {post: {body: build_post.body, category_id: build_post.category.id} } }

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
        let(:body) { {post: {body: build_post.body, category_id: 1} } }


        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {post: {body: "", category_id: 1} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/posts/{id}' do

    get('show post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:post){
          create(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { post.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
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
                      body: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'
      response(200, 'Successful') do
        let(:post){
          create(:post)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:body) { {post: {body: build_post.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
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
        let(:body) { {post: {body: build_post.body} } }

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
    end
  end
end
