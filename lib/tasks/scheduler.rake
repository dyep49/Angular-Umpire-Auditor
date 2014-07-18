desc "This task is called by the Heroku scheduler add-on"
task :update_data => :environment do
  puts "Updating data"

  gids = BuildLinks.last_night.uniq
  gids.each do |gid|
    SeedHelper.seed_gid(gid)
  end

  games = Game.where(game_date: Date.today.prev_day)
  games.each do |game|
    Game.set_calls(game)
  end

  Day.create_days(games)
  Umpire.update_ranking
  Umpire.update_year_ranking(Date.today.year)
  
  puts "updating data complete"

  last_day = Day.order(:game_date).last

  if last_day.last.game_date == Date.today.prev_day
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end

    client.update(last_day.tweet)
  end

end

