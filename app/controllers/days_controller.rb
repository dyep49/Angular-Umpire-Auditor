class DaysController < ApplicationController

  def index
    render json: Day.all
  end


	def dates
    days = Day.pluck(:game_date)
    render json: days
	end

end