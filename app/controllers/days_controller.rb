class DaysController < ApplicationController

  def index
    render json: Day.all
  end


	def dates
    days = Day.all
    day_array = []
    days.each do |day|
      day_array << day.game_date
    end
		render json: day_array
	end

end