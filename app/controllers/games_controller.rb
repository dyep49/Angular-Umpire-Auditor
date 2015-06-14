class GamesController < ApplicationController


def show
  date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
	day = Day.find_by(game_date: date)


  render json: day.to_client_json
end


end

