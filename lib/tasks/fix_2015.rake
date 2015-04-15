require "#{Rails.root}/lib/assets/seed_helper.rb"
require "#{Rails.root}/lib/assets/build_links.rb"

require 'pry'

namespace :db do
  desc "fix 2015 data"
  task fix_2015: :environment do 
    opening_day = Date.new(2015, 4, 5)
    last_day = Date.new(2015, 4, 13)
    days = (opening_day..last_day)

    days.each do |day|
      gids = BuildLinks.parse_gids_by_date(day).uniq
      binding.pry
      gids.each do |gid|
        SeedHelper.seed_gid(gid)
      end

      games = Game.where(game_date: day)
      games.each do |game|
        Game.set_calls(game)
      end

      Day.create_days(games)
    end

    Umpire.update_ranking
    Umpire.update_ranking(Date.today.year)

    $redis.del 'days'
  end
end

