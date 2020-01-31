# config/initializers/redis.rb

# $redis = Redis::Namespace.new("tutorial_post", :redis => Redis.new, :host => 'localhost', :port => 7001)
$redis = Redis.new(:host => '127.0.0.1', :port => 7001)