require 'swagger_helper'

RSpec.describe 'Users API' do
  include ApiHelper

  path '/users' do

    get('list users') do
      tags 'User'
      security [Bearer: []]
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string,  required: true, schema: {
          type: :string,
          properties: {
              Authorization: { type: :string }
          }
      }, description: 'JWT token for Authorization'

      response(200, 'successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { "invalid token" }
        run_test!
      end
    end

    # post('create user') do
    #   tags 'User'
    #   produces 'application/json'
    #   parameter name: :body, in: :user, description: 'User Object Parameter', schema: {
    #       type: :object,
    #       properties: {
    #           name: { type: :string },
    #           username: { type: :string },
    #           email: { type: :string },
    #           password: { type: :string },
    #           password_confirmation: { type: :string }
    #       },
    #       required: [ 'name', 'username', 'email', 'password', 'password_confirmation' ]
    #   }
    #
    #
    #   # -H "accept: application/json" -H "Content-Type: application/json"
    #   let(:'Accept') { 'application/json' }
    #   let(:user) { {name: "aa", username:"aas", email: "x1wins@changwoo.net", password: "password123", password_confirmation: "password123"} }
    #   response(201, 'User created') do
    #     run_test!
    #   end
    # end
  end

  # path '/users/{_username}' do
  #   get('show user') do
  #     tags 'User'
  #     consumes 'application/json'
  #     parameter name: :_username, in: :path, description: 'helloworld', schema: {
  #         type: :string,
  #         properties: {
  #             _username: { type: :string }
  #         },
  #         required: ['_username']
  #     }
  #     produces 'application/json'
  #     let(:_username) { "helloworld" }
  #     response(200, 'successful') do
  #       let(:user){
  #         create(:user)
  #       }
  #       let(:_username) { user.username }
  #       run_test!
  #     end
  #
  #     response(404, 'not found') do
  #       let(:_username) { "hello" }
  #       run_test!
  #     end
  #   end

  #   patch('update user') do
  #     response(200, 'successful') do
  #       let(:_username) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   put('update user') do
  #     response(200, 'successful') do
  #       let(:_username) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  #       end
  #       run_test!
  #     end
  #   end
  #
  #   delete('delete user') do
  #     response(200, 'successful') do
  #       let(:_username) { '123' }
  #
  #       after do |example|
  #         example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
