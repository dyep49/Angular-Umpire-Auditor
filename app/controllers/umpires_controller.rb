class UmpiresController < ApplicationController

def index
	ranking = Umpire.get_umpire_ranking

  if ranking.to_a.empty?
    ranking = Umpire.update_ranking
  end

	render json: ranking
end

def show
	umpire = Umpire.find(params[:id])
	games = umpire.games
  games = games.select{|game| game.total_calls && game.total_calls > 0}

	render json: {games: games, umpire: umpire}
end

def show_year
  year = params[:year].to_i
  ranking = Umpire.get_umpire_ranking(year)

  if ranking.to_a.empty?
    ranking = Umpire.update_ranking(year)
  end

  render json: ranking
end

end