class Day < ActiveRecord::Base

	def self.most_recent
		day = Day.order(game_date: :desc).first
	end

	def self.create_days(games)
		dates = []
		games.each do |game|
			dates << game.game_date
		end
		dates = dates.uniq

		dates.each do |date|
			begin
				unless Day.all.any?{|day| day.game_date == date}
					games = Game.where(game_date: date)
					game = games.max_by(&:worst_call)
					worst_call = game.worst_call
					umpire = game.umpire
					teams = game.teams
					unless worst_call.total_distance_missed == 0
						Day.create(
							game_date: date,
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
							play: worst_call.play,
							inning_half: worst_call.inning_half,
							img_date: date.strftime("%Y-%m-%d")
						)
					end
				end
			rescue Exception => e
				puts e.message
				puts e.backtrace.inspect
			end
		end
	end

	def tweet
		inning_int = inning.to_i
		miss_inches = total_distance_missed*12.round(2)
		"With a #{ball_count}-#{strike_count} count in the #{inning_half} of the #{inning_int.ordinalize}, umpire #{umpire} called a strike on a pitch that missed the strike zone by #{miss_inches} inches"
	end

end

