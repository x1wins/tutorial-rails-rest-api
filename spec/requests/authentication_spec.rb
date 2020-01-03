require 'swagger_helper'

RSpec.describe 'authentication', type: :request do

  path '/auth/login' do

    post('login authentication') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end
end
