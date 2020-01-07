# require 'swagger_helper'
#
# RSpec.describe 'comments', type: :request do
#
#   path '/comments' do
#
#     get('list comments') do
#       response(200, 'successful') do
#
#         after do |example|
#           example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
#         end
#         run_test!
#       end
#     end
#
#     post('create comment') do
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
#   path '/comments/{id}' do
#     # You'll want to customize the parameter types...
#     parameter name: 'id', in: :path, type: :string, description: 'id'
#
#     get('show comment') do
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
#     patch('update comment') do
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
#     put('update comment') do
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
#     delete('delete comment') do
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
