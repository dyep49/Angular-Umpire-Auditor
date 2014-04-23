class Game < ActiveRecord::Base

	has_and_belongs_to_many :teams
	belongs_to :umpire
	has_many :pitches


	def self.set_date(game)
		year = game.gid[0..3]
		month = game.gid[5..6]
		day = game.gid[8..9]
		game.game_date = Date.parse("#{day}-#{month}-#{year}")
		game.save!
	end

	def self.set_calls(game)
    pitches = game.pitches

    unless game.correct_calls
	    correct_calls = pitches.where(correct_call: true).count
	    game.correct_calls = correct_calls
	  end

	  unless game.incorrect_calls 
	    incorrect_calls = pitches.where(correct_call: false).count
	    game.incorrect_calls = incorrect_calls
	  end

	  unless game.total_calls
			total_calls = correct_calls + incorrect_calls
			game.total_calls = total_calls
		end

    game.save!
	end

	def self.set_team(game)
		teams = game.teams
		game.home_team_abbrev = teams.first.abbreviation
		game.away_team_abbrev = teams.last.abbreviation
		game.save!
	end

	def self.most_recent
		date = Game.order(game_date: :desc).first.game_date
		Game.where(game_date: date)
	end

	def worst_call
		pitches.max_by(&:total_distance_missed)
	end

end