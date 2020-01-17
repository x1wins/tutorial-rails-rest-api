Rails.application.configure do
  config.autoflush_log = true
  config.lograge.base_controller_class = 'ActionController::API'
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.logger = LogStashLogger.new(type: :udp, host: 'localhost', port: 5000, sync: true)
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
end
