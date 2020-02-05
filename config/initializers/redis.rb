# config/initializers/redis.rb

$redis = Redis::Namespace.new("tutorial_post", :redis => Redis.new(:host => 'redis', :port => 6379))
