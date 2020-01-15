# config/initializers/lograge.rb
# OR
# config/environments/production.rb
Rails.application.configure do
  config.lograge.base_controller_class = 'ActionController::API'

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.logger = LogStashLogger.new(type: :tcp, host: 'localhost', port: 5000)
  config.lograge.custom_options = lambda do |event|
    exceptions = %w(controller action format id)
    {
      params: event.payload[:params].except(*exceptions),
      type: :rails,
      environment: Rails.env,
      remote_ip: event.payload[:ip],
      HTTP_AUTHORIZATION: event.payload[:headers][:HTTP_AUTHORIZATION],
      email: event.payload[:email],
      user_id: event.payload[:user_id]
    }
  end

  # Optional, max number of items to buffer before flushing. Defaults to 50
  config.logstash.buffer_max_items = 50

  # Optional, max number of seconds to wait between flushes. Defaults to 5
  config.logstash.buffer_max_interval = 10

  # Optional, drop message when a connection error occurs. Defaults to false
  config.logstash.drop_messages_on_flush_error = false

  # Optional, drop messages when the buffer is full. Defaults to true
  config.logstash.drop_messages_on_full_buffer = true

  config.logstash.max_message_size = 4096
  config.logstash.buffer_max_items = 8192
  config.logstash.buffer_max_interval = 1
end
