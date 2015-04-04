require "#{Rails.root}/lib/assets/seed_helper.rb"
require "#{Rails.root}/lib/assets/build_links.rb"

namespace :db do 
	desc "Creates gid urls and seeds database"
	task seed_year: :environment do
		gid_url_array = BuildLinks.gid_info.uniq
		gid_url_array.each do |gid|
				SeedHelper.seed_gid(gid)
		end
    games = Game.all.select do |game|
      game.game_date.year == 2012
    end
    games.each do |game|	
	    Game.set_calls(game)
	  end
    Day.create_days(games)
	end	
end


# Game.where(game_date: Date.today.prev_day).each{|game| game.pitches.delete_all; game.destroy!}
