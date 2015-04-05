
# if ENV["RAILS_ENV"] == "production" 
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
# else 
#   $redis = Redis::Namespace.new("umpire_auditor", :redis => Redis.new)
# end