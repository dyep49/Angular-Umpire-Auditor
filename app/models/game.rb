class Game < ActiveRecord::Base

	has_and_belongs_to_many :teams
	belongs_to :umpire
	has_many :pitches


	def self.set_date(game)
		year = game.gid[0..3]
		month = game.gid[5..6]
		day = game.gid[8..9]
		game.game_date = Date.parse("#{day}-#{month}-#{year}")
		game.save!
	end

end