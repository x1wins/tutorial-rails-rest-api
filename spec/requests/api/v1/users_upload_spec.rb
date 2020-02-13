require 'swagger_helper'

RSpec.describe 'Users Avatar API', type: :request do
  include ApiHelper

  let(:uploadfile_avatar){
    Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/user.png"))
  }

  path '/api/v1/users/' do
    post('create user') do
      tags 'User - multipart/form-data'
      consumes 'multipart/form-data'
      parameter name: 'user[name]', in: :formData, type: :string, required: true
      parameter name: 'user[username]', in: :formData, type: :string, required: true
      parameter name: 'user[email]', in: :formData, type: :string, required: true
      parameter name: 'user[password]', in: :formData, type: :string, required: true
      parameter name: 'user[password_confirmation]', in: :formData, type: :string, required: true
      parameter name: 'user[avatar]', in: :formData, type: :file
      produces 'application/json'
      let(:build_user){
        build(:user, avatar: uploadfile_avatar)
      }
      response(201, 'User created') do
        let(:'user[name]') { build_user.name }
        let(:'user[username]') { build_user.username }
        let(:'user[email]') { build_user.email }
        let(:'user[password]') { build_user.password }
        let(:'user[password_confirmation]') { build_user.password_confirmation }
        let(:'user[avatar]') { uploadfile_avatar }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/v1/users/{_username}' do
    put('update user') do
      tags 'User - multipart/form-data'
      consumes 'multipart/form-data'
      security [Bearer: []]
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :_username, in: :path, description: 'username', default: 'helloworld', schema: {
          type: :string,
          properties: {
              _username: { type: :string }
          },
          required: ['_username']
      }

      parameter name: 'user[name]', in: :formData, type: :string, required: true
      parameter name: 'user[username]', in: :formData, type: :string, required: true
      parameter name: 'user[email]', in: :formData, type: :string, required: true
      parameter name: 'user[password]', in: :formData, type: :string, required: true
      parameter name: 'user[password_confirmation]', in: :formData, type: :string, required: true
      parameter name: 'user[avatar]', in: :formData, type: :file
      produces 'application/json'
      response(200, 'Successful') do
        let(:user){
          create(:user, avatar: uploadfile_avatar)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:_username) { user.username }
        let(:'user[name]') { user.name }
        let(:'user[username]') { user.username }
        let(:'user[email]') { user.email }
        let(:'user[password]') { user.password }
        let(:'user[password_confirmation]') { user.password_confirmation }
        let(:'user[avatar]') { uploadfile_avatar }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

end
