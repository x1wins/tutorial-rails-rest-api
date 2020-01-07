# require 'swagger_helper'
#
# RSpec.describe 'posts', type: :request do
#
#   path '/posts' do
#
#     get('list posts') do
#       response(200, 'successful') do
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#
#     post('create post') do
#       response(200, 'successful') do
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#   end
#
#   path '/posts/{id}' do
#     # You'll want to customize the parameter types...
#     parameter name: 'id', in: :path, type: :string, description: 'id'
#
#     get('show post') do
#       response(200, 'successful') do
#         let(:id) { '123' }
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#
#     patch('update post') do
#       response(200, 'successful') do
#         let(:id) { '123' }
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#
#     put('update post') do
#       response(200, 'successful') do
#         let(:id) { '123' }
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#
#     delete('delete post') do
#       response(200, 'successful') do
#         let(:id) { '123' }
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#   end
# end
