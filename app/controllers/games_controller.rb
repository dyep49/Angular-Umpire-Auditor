class GamesController < ApplicationController


def show
	date = "#{params[:year]}-#{params[:month]}-#{params[:day]}"
	day = Day.find_by(game_date: Date.parse(date))

	render json: {homeTeam: day.home_team, awayTeam: day.away_team, game: day.game_date, pitch: day.total_distance_missed, umpire: day.umpire, umpire_id: day.umpire_id}
end


end

