class GamesController < ApplicationController


def show
	date = "#{params[:year]}-#{params[:month]}-#{params[:day]}"
	games = Game.where(game_date: date)
	game = games.max_by(&:worst_call)
	worst_call = game.worst_call
	umpire = game.umpire
	teams = game.teams

	render json: {homeTeam: teams.first, awayTeam: teams.last, game: game, pitch: worst_call, umpire: umpire}
end


end