module CreateAssociations
	
	def self.game_umpire(game)
		unless game.umpire_id
			umpire = Umpire.find_by(mlb_umpire_id: game.mlb_umpire_id)
			umpire.games << game
		end
	end 

	def self.game_pitch(game)
		Pitch.where(gid: game.gid).each do |pitch|
			unless pitch.game_id
				game.pitches << pitch
			end
		end
	end

	def self.team_game(team)
  	games = Game.where(home_team_id: team.team_id) + Game.where(away_team_id: team.team_id)
  	games.each do |game|
  		unless team.games.include?(game)
	  		team.games << game
	  	end
	  end
	end

end
