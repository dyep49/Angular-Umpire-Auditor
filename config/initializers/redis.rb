
if ENV["RAILS_ENV"] == "production" 
  uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
  $redis = Redis::Namespace.new("umpire_auditor", :host => uri.host, :port => uri.port, :password => uri.password)
else 
  $redis = Redis::Namespace.new("umpire_auditor", :redis => Redis.new)
end