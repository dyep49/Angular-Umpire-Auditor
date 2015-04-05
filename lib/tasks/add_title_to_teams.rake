namespace :db do 
	desc "Adds team title to Team models"
	task add_title_to_team: :environment do 
		Team.all.each do |team|
			full = team.full_name.split(' ')
			team_city = team.city.split(' ')
			team.title = (full - team_city).join('')
			team.save!
		end

		dodgers = Team.find_by(full_name: "Los Angeles Dodgers")
		cubs = Team.find_by(full_name: "Chicago Cubs")
		white_sox = Team.find_by(full_name: "Chicago White Sox")
		angels = Team.find_by(full_name: "Los Angeles Angels")
		mets = Team.find_by(full_name: "New York Mets")
		yankees = Team.find_by(full_name: "New York Yankees")

		dodgers.title = "Dodgers"
		dodgers.save!
		cubs.title = "Cubs"
		cubs.save!
		white_sox.title = "WhiteSox"
		white_sox.save!
		angels.title = "Angels"
		angels.save!
		mets.title = "Mets"
		mets.save!
		yankees.title = "Yankees"
		yankees.save!
	end
end

