class Game < ActiveRecord::Base
has_and_belongs_to_many :teams
belongs_to :umpire
has_many :pitches



	def self.most_recent
		gid = Game.all.sort_by(&:gid).last.gid
		year = gid[0..3]
		month = gid[5..6]
		day = gid[8..9]
		"#{day}-#{month}-#{year}"
	end

end