require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
        swagger: '2.0',
        info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      securityDefinitions: {
          Bearer: {
              description: "Generate JWT",
              type: :apiKey,
              name: :Authorization,
              in: :header
          }
      },
      definitions: {
          user: {
              type: :object,
              properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  username: { type: :string },
                  email: { type: :string },
                  avatar: { type: :string }
              }
          },
          category: {
              type: :object,
              properties: {
                  id: { type: :integer },
                  title: { type: :string },
                  body: { type: :string },
                  posts: {
                      type: :array,
                      items: {
                          '$ref' => '#/definitions/post'
                      }
                  }
              }
          },
          post: {
              type: :object,
              properties: {
                  id: { type: :integer },
                  title: { type: :string },
                  body: { type: :string },
                  user: { '$ref' => '#/definitions/user' },
                  category: { '$ref' => '#/definitions/category' },
                  files: {
                      type: :array,
                      items: {
                          type: :object,
                          properties: {
                              id: { type: :integer },
                              url: { type: :string }
                          }
                      }
                  },
                  comments: {
                      type: :array,
                      items: {
                          '$ref' => '#/definitions/comment'
                      }
                  }
              },
              required: [ 'id', 'title', 'body' ]
          },
          comment: {
              type: :object,
              properties: {
                  id: { type: :integer },
                  body: { type: :string },
                  user: { '$ref' => '#/definitions/user' }
              },
              required: [ 'id', 'body' ]
          },
          pagination: {
              type: :object,
              properties: {
                  current_page: { type: :integer },
                  next_page: { type: :integer },
                  prev_page: { type: :integer },
                  total_pages: { type: :integer },
                  total_count: { type: :integer }
              }
          },
          categories: {
              type: :array,
              items: {
                  '$ref' => '#/definitions/category'
              }
          },
          posts: {
              type: :object,
              properties: {
                  posts: {
                      type: :array,
                      items: {
                          '$ref' => '#/definitions/post'
                      }
                  },
                  posts_pagination: { '$ref' => '#/definitions/pagination' }
              }
          },
          comments: {
              type: :array,
              items: {
                  '$ref' => '#/definitions/comment'
              }
          },
          users: {
              type: :array,
              items: {
                  '$ref' => '#/definitions/user'
              }
          }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end

