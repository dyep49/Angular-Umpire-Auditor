class HomeController < ApplicationController

def index
end

def worst_call
	day = Day.most_recent

	render json: {homeTeam: day.home_team, awayTeam: day.away_team, game: day.game_date, imgDate: day.img_date, pitch: day.total_distance_missed, umpire: day.umpire, umpire_id: day.umpire_id, ballCount: day.ball_count, strikeCount: day.strike_count, inning: day.inning, inningHalf: day.inning_half, outs: day.outs}
end



end