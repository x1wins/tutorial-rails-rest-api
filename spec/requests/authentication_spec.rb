require 'swagger_helper'

RSpec.describe 'Authentication API' do
  path '/auth/login' do
    post('login authentication') do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :email, in: :query, type: :string, required: true, default: 'hello@changwoo.org', schema: {
          type: :string,
          properties: {
              email: { type: :string }
          }
      }, description: 'Email for Login'

      parameter name: :password, in: :query, type: :string, required: true, default: 'hello1234', schema: {
          type: :string,
          properties: {
              password: { type: :string }
          }
      }, description: 'Password for Login'

      response(200, 'ok') do
        let(:user){
          create(:user)
        }
        let(:email) { user.email }
        let(:password) { user.password }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:email) { 'hello@changwoo.org' }
        let(:password) { 'aaaa' }
        run_test!
      end
    end
  end
end
