# config/initializers/redis.rb
redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
$redis = Redis::Namespace.new(redis_config['namespace'], redis: Redis.new(host: redis_config['host'], port: redis_config['port']))


