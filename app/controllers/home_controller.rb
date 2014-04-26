class HomeController < ApplicationController

def index
end

def worst_call
	day = Day.most_recent

	render json: {homeTeam: day.home_team, awayTeam: day.away_team, game: day.game_date, pitch: day.total_distance_missed, umpire: day.umpire}
end



end