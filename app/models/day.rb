class Day < ActiveRecord::Base

	def self.most_recent
		day = Day.order(game_date: :desc).first
	end

	def self.create_days(games)
		games.each do |game|
			begin
				unless Day.all.any?{|day| day.game_date == game.game_date}
					games = Game.where(game_date: game.game_date)
					game = games.max_by(&:worst_call)
					worst_call = game.worst_call
					umpire = game.umpire
					teams = game.teams
					Day.create(
						game_date: game.game_date,
						umpire: umpire.name,
						home_team: teams.first.full_name,
						away_team: teams.last.full_name,
						total_distance_missed: worst_call.total_distance_missed
					)
				end
			rescue
				puts "RESCUED"
			end
		end
	end

end



