class UmpiresController < ApplicationController

def index
	ranking = Umpire.read_umpire_csv
	render json: ranking
end

def show
	umpire = Umpire.find(params[:id])
	games = umpire.games

	render json: {games: games, umpire: umpire}
end


end