class Team < ActiveRecord::Base
	has_and_belongs_to_many :games
	has_many :pitchers


	def set_title
		full = self.full_name.split(' ')
		team_city = self.city.split(' ')
		(full - team_city).join('')
	end
end