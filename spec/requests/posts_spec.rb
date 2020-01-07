require 'swagger_helper'

RSpec.describe 'posts', type: :request do
  include ApiHelper

  path '/posts' do

    get('list posts') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :page, in: :query, type: :string, required: true, default: '1', description: 'Page number'
      produces 'application/json'
      response(200, 'successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:page) { '1' }

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
      response(201, 'successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:build_post){
          build(:post)
        }
        let(:body) { {post: {body: build_post.body} } }

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
      response(200, 'successful') do
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
      response(200, 'successful') do
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
    end

    delete('delete post') do
      tags 'Post'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(204, 'successful') do
        let(:post){
          create(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }

        run_test!
      end
    end
  end
end
