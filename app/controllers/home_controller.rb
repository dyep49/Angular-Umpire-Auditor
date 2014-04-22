class HomeController < ApplicationController

def index
end

def worst_call
	games = Game.most_recent
	game = games.max_by(&:worst_call)
	worst_call = game.worst_call
	umpire = game.umpire
	teams = game.teams

	render json: {homeTeam: teams.first, awayTeam: teams.last, game: game, pitch: worst_call, umpire: umpire}
end



end