# config/initializers/redis.rb
redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
redis = Redis.new(host: redis_config['host'], port: redis_config['port'])
if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
$redis = Redis::Namespace.new(redis_config['namespace'], redis: redis)



