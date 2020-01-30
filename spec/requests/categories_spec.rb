require 'swagger_helper'

RSpec.describe 'Cateogories API', type: :request do
  include ApiHelper

  path '/categories' do

    get('list categories') do
      tags 'Category'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :page, in: :query, type: :integer, default: '1', description: 'Page number'
      parameter name: :per, in: :query, type: :integer, description: 'Per page number'
      parameter name: :post_page, in: :query, type: :integer, description: 'Page number for Post'
      parameter name: :post_per, in: :query, type: :integer, description: 'Per page number For Post'
      produces 'application/json'

      response(200, 'Category Pagination') do
        let(:total_count) { 12 }
        let(:admin){
          create(:admin)
        }
        before do
          create_list(:category, total_count*2, user: admin)
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:page) { 1 }
        let(:per) { total_count/2 }
        let(:post_page) { }
        let(:post_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it do
          categories = JSON.parse(response.body, {symbolize_names: true})[:categories]
          expect(categories.class).to be(Array)
          expect(categories.length()).to eql per
        end
        run_test!
      end

      response(200, 'Nested Post Pagination') do
        let(:total_count) { 12 }
        let(:post_count) { 15 }
        let(:category){
          create(:category)
        }
        let(:admin){
          create(:admin)
        }
        let(:post_user){
          create(:user)
        }

        before do
          categories = create_list(:category, total_count*2, user: admin)
          categories.each {|category|
            create_list(:post, post_count , category: category, user: post_user)
          }
        end

        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:category_id) { category.id }
        let(:page) { 1 }
        let(:per) { total_count/2 }
        let(:post_page) { 1 }
        let(:post_per) { 10 }
        let(:search) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end

        it 'returns a included posts response' do
          categories = JSON.parse(response.body, {symbolize_names: true})[:categories]
          categories.each {|category|
            posts = category[:posts]
            expect(posts.class).to be(Array)
            expect(posts.length()).to eql post_per
          }
        end
        run_test!
      end

      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:page) { 1 }
        let(:per) { }
        let(:post_page) { }
        let(:post_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:Authorization) { "Bearer invalid token" }
        let(:page) { 1 }
        let(:per) { }
        let(:post_page) { }
        let(:post_per) { }
        
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    post('create category') do
      tags 'Category'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              category: {
                  type: :object,
                  properties: {
                      title: { type: :string },
                      body: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'
      response(201, 'Successful') do
        let(:admin){
          create(:admin)
        }
        let(:build_category){
          build(:category)
        }
        let(:Authorization) { authenticated_header(user: admin) }
        let(:body) { {category: {title: build_category.title, body: build_category.body } } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:build_category){
          build(:category)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:body) { {category: {title: build_category.title, body: build_category.body } } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden') do
        let(:user){
          create(:user)
        }
        let(:build_category){
          build(:category)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:body) { {category: {title: build_category.title, body: build_category.body } } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'Unprocessable Entity') do
        let(:admin){
          create(:admin)
        }
        let(:Authorization) { authenticated_header(user: admin) }
        let(:body) { {category: {title: "", body: "" } } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/categories/{id}' do

    get('show category') do
      tags 'Category'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :post_page, in: :query, type: :integer, description: 'Page number for Post'
      parameter name: :post_per, in: :query, type: :integer, description: 'Per page number For Post'
      produces 'application/json'
      response(200, 'Successful') do
        let(:user){
          create(:user)
        }
        let(:category){
          create(:category)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { category.id }
        let(:post_page) { }
        let(:post_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:category){
          create(:category)
        }
        let(:Authorization) { "Bearer invalid token" }
        let(:id) { category.id }
        let(:post_page) { }
        let(:post_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'Not Found') do
        let(:user){
          create(:user)
        }
        let(:invalid_category_id){
          1
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { invalid_category_id }
        let(:post_page) { }
        let(:post_per) { }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update category') do
      tags 'Category'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              category: {
                  type: :object,
                  properties: {
                      body: { type: :string }
                  }
              }
          }
      }
      produces 'application/json'
      response(200, 'Successful') do
        let(:admin){
          create(:admin)
        }
        let(:category){
          create(:category, user: admin)
        }
        let(:build_category){
          build(:category)
        }
        let(:Authorization) { authenticated_header(user: category.user) }
        let(:id) { category.id }
        let(:body) { {category: {body: build_category.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:category){
          create(:category)
        }
        let(:build_category){
          build(:category)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { category.id }
        let(:body) { {category: {body: build_category.body} } }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    delete('delete category') do
      tags 'Category'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string, description: 'JWT token for Authorization'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      produces 'application/json'
      response(204, 'Successful') do
        let(:admin){
          create(:admin)
        }
        let(:category){
          create(:category, user: admin)
        }
        let(:Authorization) { authenticated_header(user: category.user) }
        let(:id) { category.id }

        run_test!
      end

      response(403, 'Forbidden Unathorized') do
        let(:category){
          create(:category)
        }
        let(:user){
          create(:user)
        }
        let(:Authorization) { authenticated_header(user: user) }
        let(:id) { category.id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end
end
