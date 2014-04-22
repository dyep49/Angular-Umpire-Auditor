require "#{Rails.root}/lib/assets/create_associations.rb"

namespace :association do 
	desc "Sets associations between umpires and games"
	task game_umpire: :environment do 
		Game.all.each do |game|
			begin
				CreateAssociations.game_umpire(game)
			rescue
				puts "RESCUED"
			end
		end
	end

	desc "Sets associations between game and pitches"
	task game_pitches: :environment do 
		Game.all.each do |game|
			begin
				CreateAssociations.game_pitch(game)
				puts "added game"
			rescue
				puts "RESCUED"
			end
		end
	end

	desc "Sets associations bewteen teams and games"
	task team_game: :environment do 
		Team.all.each do |team|
			begin
				CreateAssociations.team_game(team)
				puts "added game"
			rescue
				puts "RESCUED"
			end
		end
	end
end