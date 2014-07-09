desc "This task is called by the Heroku scheduler add-on"
task :update_data => :environment do
  puts "Updating data"

  gids = BuildLinks.last_night
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
  
  puts "done"
end

