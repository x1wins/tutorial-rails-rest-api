require 'swagger_helper'

RSpec.describe 'authentication', type: :request do

  path '/auth/login' do

    post('login authentication') do
      tags 'auth'
      consumes 'application/json'
      parameter name: :auth, in: :query, schema: {
          type: :object,
          properties: {
              email: { type: :string },
              password: { type: :string }
          },
          required: [ 'email', 'password' ]
      }

      response(200, 'successful') do
        let(:auth) { { email: 'hello@changwoo.org', password: 'hello1234' } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:auth) { { email: 'hello@changwoo.org', password: 'aaaa' } }
        run_test!
      end
    end
  end
end
