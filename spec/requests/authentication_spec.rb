require 'swagger_helper'

RSpec.describe 'Authentication API' do
  path '/auth/login' do
    post('login authentication') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :body, in: :query, description: 'Params for Authentication', schema: {
          type: :object,
          properties: {
              email: { type: :string },
              password: { type: :string }
          },
          required: [ 'email', 'password' ]
      }
      produces 'application/json'

      response(200, 'ok') do
        let(:user){
          create(:user)
        }
        let(:body) { {auth: { email: user.email, password: user.password } } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:auth) { { email: 'hello@changwoo.org', password: 'aaaa' } }
        run_test!
      end
    end
  end
end
