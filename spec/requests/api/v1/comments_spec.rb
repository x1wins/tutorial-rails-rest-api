require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  include ApiHelper

  path '/api/v1/comments' do

    get('list comments') do
      tags 'Comment'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :post_id, in: :query, type: :integer, default: '1', description: 'Post Id'
      parameter name: :page, in: :query, type: :integer, default: '1', description: 'Page number'
      parameter name: :per, in: :query, type: :integer, description: 'Per page number'
      produces 'application/json'

      response(200, 'Pagination') do
        let(:total_count) { 12 }
        let(:post){
          create(:post)
        }
        before do
          create_list(:comment, total_count*2 , post: post)
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:post_id) { post.id }
        let(:page) { 1 }
        let(:per) { total_count/2 }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it do
          comments = JSON.parse(response.body, {symbolize_names: true})[:comments]
          expect(comments.class).to be(Array)
          expect(comments.length()).to eql per
        end
        run_test!
      end

      response(200, 'Successful') do
        schema '$ref' => '#/definitions/comments'
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:post){
          create(:post)
        }
        let(:post_id) { post.id }
        let(:page) { 1 }
        let(:per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:Authorization) { "Bearer invalid token" }
        let(:post){
          create(:post)
        }
        let(:post_id) { post.id }
        let(:page) { 1 }
        let(:per) { }

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
          create(:post, published: true, category: category)
        }
        let(:post_id) { post.id }
        let(:page) { }
        let(:per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end

      response(404, 'Not Found Post') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:post){
          create(:post, published: false)
        }
        let(:post_id) { post.id }
        let(:page) { }
        let(:per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        run_test!
      end
    end

    post('create comment') do
      tags 'Comment'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :body, in: :body, required: true, schema: {'$ref' => '#/definitions/comment_param' }
      produces 'application/json'
      response(201, 'Successful') do
        schema '$ref' => '#/definitions/comment'
        let(:user){
          create(:user)
        }
        let(:created_post){
          create(:post)
        }
        let(:build_comment){
          build(:comment)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {comment: {body: build_comment.body, post_id: created_post.id } } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:build_comment){
          build(:comment)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:body) { {comment: {body: build_comment.body} } }

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
        let(:body) { {comment: {body: ""} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/{id}' do

    get('show comment') do
      tags 'Comment'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(200, 'Successful') do
        schema '$ref' => '#/definitions/comment'
        let(:user){
          create(:user)
        }
        let(:comment){
          create(:comment)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { comment.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:comment){
          create(:comment)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:id) { comment.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found') do
        let(:user){
          create(:user)
        }
        let(:invalid_comment_id){
          1
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { invalid_comment_id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update comment') do
      tags 'Comment'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :body, in: :body, required: true, schema: {'$ref' => '#/definitions/comment_param' }
      produces 'application/json'
      response(200, 'Successful') do
        schema '$ref' => '#/definitions/comment'
        let(:comment){
          create(:comment)
        }
        let(:build_comment){
          build(:comment)
        }
        let(:Authorization) { authenticated_header(user: comment.user) }
        let(:id) { comment.id }
        let(:body) { {comment: {body: build_comment.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:comment){
          create(:comment)
        }
        let(:build_comment){
          build(:comment)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { comment.id }
        let(:body) { {comment: {body: build_comment.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    delete('delete comment') do
      tags 'Comment'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(204, 'Successful') do
        let(:comment){
          create(:comment)
        }
        let(:Authorization) { authenticated_header(user: comment.user) }
        let(:id) { comment.id }

        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:comment){
          create(:comment)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { comment.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end
end
