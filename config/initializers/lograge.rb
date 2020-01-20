Rails.application.configure do
  enable = Rails.configuration.elk['enable']
  protocal = Rails.configuration.elk['protocal']
  host = Rails.configuration.elk['host']
  port = Rails.configuration.elk['port']

  if enable
    config.autoflush_log = true
    config.lograge.base_controller_class = 'ActionController::API'
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new
    config.lograge.logger = LogStashLogger.new(type: protocal, host: host, port: port, sync: true)
    config.lograge.custom_options = lambda do |event|
      exceptions = %w(controller action format id)
      {
          type: :rails,
          environment: Rails.env,
          remote_ip: event.payload[:ip],
          email: event.payload[:email],
          user_id: event.payload[:user_id],
          request: {
              headers: event.payload[:headers],
              params: event.payload[:params].except(*exceptions)
          }
      }
    end
  end

end
