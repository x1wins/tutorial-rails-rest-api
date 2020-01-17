# config/initializers/lograge.rb
# OR
# config/environments/production.rb
require 'logstash-logger'

Rails.application.configure do
  enable = Rails.configuration.elk['enable']
  protocal = Rails.configuration.elk['protocal']
  host = Rails.configuration.elk['host']
  port = Rails.configuration.elk['port']

  config.autoflush_log = true

  if enable
    udp_logger = LogStashLogger.new(type: :udp, host: 'localhost', port: 5000)
    config.lograge.base_controller_class = 'ActionController::API'
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new
    config.lograge.logger = udp_logger #LogStashLogger.new(type: protocal, host: host, port: port)
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
    config.logstash.buffer_max_items = 1999

    # Optional, max number of seconds to wait between flushes. Defaults to 5
    config.logstash.buffer_max_interval = 5

    # # Optional, drop message when a connection error occurs. Defaults to false
    config.logstash.drop_messages_on_flush_error = false

    # Optional, drop messages when the buffer is full. Defaults to true
    config.logstash.drop_messages_on_full_buffer = true


  end
end
