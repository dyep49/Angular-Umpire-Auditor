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
						umpire_id: umpire.id,
						home_team: teams.first.full_name,
						away_team: teams.last.full_name,
						pitch_id: worst_call.id,
						total_distance_missed: worst_call.total_distance_missed,
						inning: worst_call.inning,
						ball_count: worst_call.ball_count,
						strike_count: worst_call.strike_count,
						outs: worst_call.outs,
						inning_half: worst_call.inning_half
					)
				end
			rescue Exception => e
				puts e.message
				puts e.backtrace.inspect
			end
		end
	end

end

##ADD PITCH ID AND UMPIRE ID

