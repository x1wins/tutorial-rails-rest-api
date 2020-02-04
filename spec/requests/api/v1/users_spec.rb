require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  include ApiHelper

  path '/api/v1/users' do

    get('list users') do
      tags 'User'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :page, in: :query, type: :string, required: true, default: '1', description: 'Page number'
      produces 'application/json'

      response(200, 'Successful') do
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

      response(401, 'Unauthorized') do
        let(:Authorization) { "invalid token" }
        let(:page) { '1' }
        run_test!
      end
    end

    post('create user') do
      tags 'User'
      consumes 'application/json'
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              user: {
                  type: :object,
                  properties: {
                      name: { type: :string },
                      username: { type: :string },
                      email: { type: :string },
                      password: { type: :string },
                      password_confirmation: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'

      let(:build_user){
        build(:user)
      }

      response(201, 'User created') do
        let(:body) { {user: {name: build_user.name, username:build_user.username, email: build_user.email, password: build_user.password, password_confirmation: build_user.password} } }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        it do
          data = JSON.parse(response.body)
          expect(data.class).to be(Hash)
          expect(response.status).to eq(201)
        end
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:body) { {user: {name: build_user.name, username:"", email: build_user.email, password: build_user.password, password_confirmation: build_user.password} } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{_username}' do
    get('show user') do
      tags 'User'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :_username, in: :path, description: 'username', default: 'helloworld', schema: {
          type: :string,
          properties: {
              _username: { type: :string }
          },
          required: ['_username']
      }
      produces 'application/json'
      let(:_username) { "helloworld" }

      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { user.username }
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:_username) { user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:another_user){
          create(:user)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { another_user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { "hello" }
        run_test!
      end
    end

    put('update user') do
      tags 'User'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :_username, in: :path, description: 'username', default: 'helloworld', schema: {
          type: :string,
          properties: {
              _username: { type: :string }
          },
          required: ['_username']
      }
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              user: {
                  type: :object,
                  properties: {
                      name: { type: :string },
                      username: { type: :string },
                      email: { type: :string },
                      password: { type: :string },
                      password_confirmation: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'
      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { user.username }
        let(:body) { {user: {name: user.name, username:user.username, email: user.email, password: user.password, password_confirmation: user.password} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:_username) { user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:another_user){
          create(:user)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { another_user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
    delete('delete user') do
      tags 'User'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :_username, in: :path, description: 'username', default: 'helloworld', schema: {
          type: :string,
          properties: {
              _username: { type: :string }
          },
          required: ['_username']
      }
      produces 'application/json'

      response(204, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { user.username }
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:_username) { user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:another_user){
          create(:user)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { another_user.username }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

end
