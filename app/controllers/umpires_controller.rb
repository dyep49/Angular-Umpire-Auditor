class UmpiresController < ApplicationController

def index
	ranking = Umpire.get_umpire_ranking
	render json: ranking
end

def show
	umpire = Umpire.find(params[:id])
	games = umpire.games
  games = games.select{|game| game.total_calls && game.total_calls > 0}

	render json: {games: games, umpire: umpire}
end

def show_year
  year = params[:year]
  ranking = Umpire.get_umpire_ranking(year)

  render json: ranking

end

end