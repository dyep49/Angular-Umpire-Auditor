class DaysController < ApplicationController

	def index
		render json: Day.all
	end

end