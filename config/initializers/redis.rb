# config/initializers/redis.rb

$redis = Redis::Namespace.new("tutorial_post", :redis => Redis.new)