require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  include ApiHelper

  path '/api/v1/posts' do
    post('multipart form') do
      tags 'Post - multipart/form-data'
      security [Bearer: []]
      consumes 'multipart/form-data'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'post[body]', in: :formData, type: :string, required: true
      parameter name: 'post[category_id]', in: :formData, type: :integer, required: true
      parameter name: 'post[files][]', in: :formData, type: :file
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
        let(:'post[files][]') { Rack::Test::UploadedFile.new(Rails.root.join("spec/factories/sample.txt")) }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

end
