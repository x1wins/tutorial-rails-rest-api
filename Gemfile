source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.4', '>= 6.0.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3', '>= 4.3.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jwt-rails', '~> 0.0.1'
gem 'docker-postgres-rails', '~> 0.0.1'


gem 'jwt'
gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers', '>= 0.10.10'

group :development, :test do
  gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '>= 5.2.0'
  gem 'faker'
end

# https://github.com/rswag/rswag
gem 'rswag-api', '>= 2.3.1'
gem 'rswag-ui', '>= 2.3.1'

group :development, :test do
  gem 'rswag-specs', '>= 2.3.1'
end

gem 'kaminari', '>= 1.1.1'

gem 'lograge', '>= 0.11.2'
gem 'logstash-event'
gem 'logstash-logger'

gem 'redis'
gem 'redis-namespace'
gem 'redis-rails', '>= 5.0.2'
gem 'redis-rack-cache', '>= 2.2.1'
gem 'cloudinary'
gem 'activestorage-cloudinary-service'
