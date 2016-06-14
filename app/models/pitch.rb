class Pitch < ActiveRecord::Base
	belongs_to :game

	HALF_PLATE_WIDTH = (17/12.0)/2

	def correct_call?
		self.strike? == self.description
	end

	def strike?
		self.width_strike? && self.height_strike? ? "Called Strike" : "Ball"
	end

	def width_strike?
		self.x_location.abs < HALF_PLATE_WIDTH 
	end

	def height_strike?
		(self.y_location < self.sz_top) && (self.y_location > self.sz_bottom)
	end

	def x_miss
		if self.x_location.abs > HALF_PLATE_WIDTH
			self.distance_missed_x = (self.x_location.abs - HALF_PLATE_WIDTH).round(3)
		else
			self.distance_missed_x = 0
		end
	end

	def y_miss
		if self.y_location > self.sz_top
			self.distance_missed_y = (self.y_location - self.sz_top).round(3)
		elsif self.y_location < self.sz_bottom 
			self.distance_missed_y = (self.sz_bottom - self.y_location).round(3)
		else
			self.distance_missed_y = 0
		end
	end

	def total_miss
    total_distance_missed = Math.sqrt(self.y_miss ** 2 + self.x_miss ** 2)
	end

end
