require 'swagger_helper'

RSpec.describe 'Posts File API', type: :request do
  include ApiHelper

  let(:uploadfile){
    Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.txt"))
  }
  let(:second_uploadfile){
    Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.txt"))
  }

  path '/api/v1/posts/' do
    post('create multipart form') do
      tags 'Post - multipart/form-data'
      security [Bearer: []]
      consumes 'multipart/form-data'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'post[title]', in: :formData, type: :string, required: true
      parameter name: 'post[body]', in: :formData, type: :string, required: true
      parameter name: 'post[category_id]', in: :formData, type: :integer, required: true
      parameter name: 'post[files]', in: :formData, type: :file
      response(201, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:'post[title]') { build_post.title }
        let(:'post[body]') { build_post.body }
        let(:'post[category_id]') { build_post.category.id }
        let(:'post[files]') { [uploadfile, second_uploadfile] }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
          r = JSON.parse(response.body, symbolize_names: true)
          expect(r[:files].count).to be == 2
        end
        run_test!
      end

      response(201, 'Successful') do
        schema '$ref' => '#/definitions/posts'
        let(:user){
          create(:user)
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:'post[title]') { build_post.title }
        let(:'post[body]') { build_post.body }
        let(:'post[category_id]') { build_post.category.id }
        let(:'post[files]') { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
          r = JSON.parse(response.body, symbolize_names: true)
          expect(r[:files].count).to be == 0
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
      parameter name: 'post[title]', in: :formData, type: :string, required: true
      parameter name: 'post[body]', in: :formData, type: :string, required: true
      parameter name: 'post[files]', in: :formData, type: :file
      response(200, 'Successful') do
        schema '$ref' => '#/definitions/post'
        let(:user){
          create(:user)
        }
        let(:post){
          create(:post, files: [ uploadfile, second_uploadfile ])
        }
        let(:build_post){
          build(:post)
        }
        let(:Authorization) { authenticated_header(user: post.user) }
        let(:id) { post.id }
        let(:'post[title]') { build_post.title }
        let(:'post[body]') { build_post.body }
        let(:'post[files]') { [uploadfile] }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
          r = JSON.parse(response.body, symbolize_names: true)
          expect(r[:files].count).to be == 3
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

end
