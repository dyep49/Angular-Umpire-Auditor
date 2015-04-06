class DaysController < ApplicationController

  def index
    days = $redis.get("days")
    
    if days.to_a.empty?
      days = Day.all.to_json
      $redis.set("days", days)
    end

    render json: days
  end


	def dates
    days = Day.pluck(:game_date)
    render json: days
	end

end