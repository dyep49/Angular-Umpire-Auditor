desc "This task is called by the Heroku scheduler add-on"
task :update_data => :environment do
  puts "Updating data"

  yesterday = Date.today.prev_day

  gids = BuildLinks.parse_gids_by_date(yesterday).uniq
  gids.each do |gid|
    SeedHelper.seed_gid(gid)
  end

  games = Game.where(game_date: yesterday)
  games.each do |game|
    Game.set_calls(game)
  end

  Day.create_days(games)
  Umpire.update_ranking
  Umpire.update_ranking(Date.today.year)
  
  puts "updating data complete"

  $redis.del 'days'
end

task :tweet => :environment do 
  last_day = Day.order(:game_date).last

  #Don't tweet if the data seems weird
  if last_day.game_date == Date.today.prev_day && last_day.total_distance_missed < 1.2
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end

    client.update(last_day.tweet)
  end
end


