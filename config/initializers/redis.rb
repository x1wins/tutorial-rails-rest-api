# config/initializers/redis.rb
redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
redis_url = ENV["REDIS_URL"]
if redis_url
  uri = URI.parse(redis_url)
  redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password,
                    :connect_timeout => 10,
                    :read_timeout    => 10,
                    :write_timeout   => 10)
else
  redis = Redis.new(host: redis_config['host'], port: redis_config['port'])
end
$redis = Redis::Namespace.new(redis_config['namespace'], redis: redis)



