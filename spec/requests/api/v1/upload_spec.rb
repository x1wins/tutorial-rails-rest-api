require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  include ApiHelper

  let(:uploadfile){
    Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.txt"))
  }

  path '/api/v1/posts/' do
    post('create multipart form') do
      tags 'Post - multipart/form-data'
      security [Bearer: []]
      consumes 'multipart/form-data'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'post[body]', in: :formData, type: :string, required: true
      parameter name: 'post[category_id]', in: :formData, type: :integer, required: true
      parameter name: 'post[files][]', in: :formData, type: :file
      response(201, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:'post[body]') { build_post.body }
        let(:'post[category_id]') { build_post.category.id }
        let(:'post[files][]') { uploadfile }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(201, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:'post[body]') { build_post.body }
        let(:'post[category_id]') { build_post.category.id }
        let(:'post[files][]') { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/' do
    put('update multipart form') do
      tags 'Post - multipart/form-data'
      security [Bearer: []]
      consumes 'multipart/form-data'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: 'post[body]', in: :formData, type: :string, required: true
      parameter name: 'post[files][]', in: :formData, type: :file
      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:post){
          create(:post)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:'post[body]') { build_post.body }
        let(:'post[files][]') { uploadfile }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/attached/{attached_id}' do
    delete('delete post attached file') do
      tags 'Post - multipart/form-data'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: 'attached_id', in: :path, type: :string, description: 'attached_id'
      produces 'application/json'
      response(204, 'Successful') do
        let(:post){
          create(:post, files: [ uploadfile ])
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:attached_id) { post.files.first.id }
        run_test!
      end
    end
  end

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
        build(:user)
      }
      response(201, 'User created') do
        let(:body) { {user: {name: build_user.name, username:build_user.username, email: build_user.email, password: build_user.password, password_confirmation: build_user.password} } }
        let(:'user[avatar]') { user.avatar }
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
    end
  end

end
