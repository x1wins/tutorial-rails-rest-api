require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/api/v1/auth/login' do
    post('login authentication') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :body, in: :body, required: true, schema: {
          type: :object,
          properties: {
              email: { type: :string, required: true, description: 'Email for Login', example: 'hello@changwoo.org' },
              password: { type: :string, required: true, description: 'Password for Login', example: 'hello1234' }
          }
      }
      response(200, 'Ok') do
        schema '$ref' => '#/definitions/auth'
        let(:user){
          create(:user)
        }
        let(:body) { {email: user.email, password: user.password} }
        run_test!
      end

      response(401, 'Unauthorized') do
        let(:email) { 'hello@changwoo.org' }
        let(:password) { 'aaaa' }
        run_test!
      end
    end
  end
end
