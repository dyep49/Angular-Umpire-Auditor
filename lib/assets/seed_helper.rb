module SeedHelper

	# Regular season, all star, divisional, league, world series
	GAME_TYPES = ["R", "A", "F", "D", "L", "W"]

	def self.seed_gid(gid_url)
		begin
			puts gid_url
			game_type = self.set_game_type("#{gid_url}/linescore.json")
			#Write a test to make sure it breaks on incorrect game type
			if GAME_TYPES.include?(game_type)
				#Break into function that finds the umpire in xml and another that checks against umpires in database
				umpire_url = "#{gid_url}/players.xml"
				umpire = self.set_umpire(umpire_url)
				#Same as umpires functions comment
				game_url = "#{gid_url}/game.xml"
				game = self.set_game(game_url, umpire)
				game.game_type = game_type
				umpire.games << game
				pitches_url = "#{gid_url}/inning/inning_all.xml"
				# pitches = self.set_pitches(pitches_url)
				pitches = self.get_pitch_xml(pitches_url)
				#This could be an each loop I think
				pitches.map do |pitch| 
					pitch.gid = game.gid
					pitch.mlb_umpire_id = umpire.mlb_umpire_id
					pitch.date_string = game.game_date
					game.pitches << pitch
				end
				Game.set_calls(game)
				Game.set_team(game)
				game.home_full_name = Team.find_by(team_id: game.home_team_id).full_name
				game.away_full_name = Team.find_by(team_id: game.away_team_id).full_name
				game.save!
			end
		rescue Exception => e
			puts e.message
			puts e.backtrace.inspect
		end
	end

	def self.set_game_type(url)
		response = HTTParty.get(url)
		game_type = response["data"]["game"]["game_type"]
	end

	def self.set_umpire(umpire_url) 
		response = HTTParty.get(umpire_url)
		umpire_info = response["game"]["umpires"]["umpire"][0]
		umpire = Umpire.find_by(mlb_umpire_id: umpire_info["id"])
		unless umpire 
			umpire = Umpire.new
			umpire.name = umpire_info["name"]
			umpire.mlb_umpire_id = umpire_info["id"]
			umpire.save!
		end
		umpire
	end

	def self.set_game(game_url, umpire)
		response = HTTParty.get(game_url)
		game = Game.new
		game.home_team_id = response["game"]["team"][0]["id"]
		game.away_team_id = response["game"]["team"][1]["id"]
		game.home_team_abbrev = response["game"]["team"][0]["abbrev"]
		game.away_team_abbrev = response["game"]["team"][1]["abbrev"]
		game.gid = game_url[/gid[^\/]*/]
		game.game_date = self.gid_to_date(game.gid)
		game.mlb_umpire_id = umpire.mlb_umpire_id
		game.umpire_name = umpire.name
		home_team = self.set_team(response["game"]["team"][0])
		away_team = self.set_team(response["game"]["team"][1])
		game.save!
		home_team.games << game
		away_team.games << game
		game
	end

	def self.set_team(response)
		team_id = response["id"]
		team = Team.find_by(team_id: team_id)
		unless team
			team = Team.new
			team.team_id = response["id"]
			team.abbreviation = response["abbrev"]
			team.full_name = response["name_full"]
			team.division_id = response["division_id"]
			team.league_id = response["league_id"]
			team.code = response["code"]
			team.city = response["name"]
			team.save!
		end
		team
	end

	def self.gid_to_date(gid)
		numbers = gid.scan(/\d{2,}/).map(&:to_i)
		year = numbers[0]
		month = numbers[1]
		day = numbers[2]
		date = Date.new(year, month, day)
	end

	def self.get_pitch_xml(url)
	  response = HTTParty.get(url)
	  innings = response["game"]["inning"]
	  innings_array = []
	  innings.each do |inning|
	    innings_array << parse_inning(inning)
	  end

	  innings_array.flatten
	end

	def self.parse_inning(inning)
	  inning_num = inning["num"]
	  half_inning_array = []

	  ["top", "bottom"].each do |half|
	  	#Not all innings have a bottom half
	  	if inning[half]
		    inning_info = {inning_num: inning["num"], inning_half: half}
		    half_inning_array << parse_half_inning(inning[half], inning_info)
		  end
	  end

	  half_inning_array.flatten
	end

	#Inning info feels hacky...might be time for an atbat model?
	def self.parse_half_inning(half_inning, inning_info)
	  outs = 0
	  at_bats = half_inning["atbat"]

	  at_bat_array = []
	  #attach outs data in the loop to pitch
	  at_bats.each do |ab|
	    play = ab["des"].strip

	    pitch_array = parse_at_bat(ab)
	    pitch_array.each do |pitch|
	      pitch.outs = outs
	      pitch.play = play
	      pitch.inning = inning_info[:inning_num]
	      pitch.inning_half = inning_info[:inning_half]
	    end
	    at_bat_array << pitch_array
	    outs = ab["o"]
	  end

	  at_bat_array
	end

	def self.parse_at_bat(at_bat)
	  pitch_array = []

	  pitches = at_bat["pitch"]
	  #Weird parsing thing seems to return single pitch ABs as a hash
	  pitches = [pitches] if pitches.is_a?(Hash)

	  ball_count = 0
	  strike_count = 0

	  pitches.each do |pitch|
	    pitch_attrs = parse_pitch(pitch)
	    pitch_attrs[:ball_count] = ball_count
	    pitch_attrs[:strike_count] = strike_count

	    new_pitch = Pitch.new(pitch_attrs)

	    if judgeable?(new_pitch)
	      new_pitch.correct_call = new_pitch.correct_call?
	      calculate_miss(new_pitch) if new_pitch.description == "Called Strike"
	    end

	    updated_count = update_count({ball_count: ball_count, strike_count: strike_count, type: pitch_attrs[:type_id]})
	    ball_count = updated_count[:ball_count]
	    strike_count = updated_count[:strike_count]

	    new_pitch.save!
	    pitch_array << new_pitch
	  end


	  pitch_array
	end

	def self.calculate_miss(pitch)
	  pitch.distance_missed_x = pitch.x_miss
	  pitch.distance_missed_y = pitch.y_miss
	  pitch.total_distance_missed = pitch.total_miss
	end

	def self.judgeable?(pitch)
	  pitch.sz_top && (pitch.description == "Called Strike" || pitch.description == "Ball")
	end

	def self.update_count(count_info) 
	  if count_info[:type] == "S" && count_info[:strike_count] < 2
	    count_info[:strike_count] += 1
	  elsif count_info[:type] == "B"
	    count_info[:ball_count] += 1
	  end
	  count_info
	end

	def self.parse_pitch(pitch)
	  begin
	    {
	      description: pitch["des"],
	      pid: pitch["id"],
	      x_location: pitch["px"],
	      y_location: pitch["pz"],
	      sz_top: pitch["sz_top"],
	      sz_bottom: pitch["sz_bot"],
	      sv_id: pitch["sv_id"],
	      type_id: pitch["type"],
	      missing_data: false
	    }
	  rescue Exception => e
	    puts e.message
	    puts e.backtrace.inspect
	    {missing_data: true}
	  end
	end

	# #Almost certainly the cause of all the problems
	# def self.set_pitches(pitches_url)
	# 	pitch_array = []
	# 	pitches_url = URI(pitches_url)
	# 	#Why is this not HTTParty?
	# 	response = Net::HTTP.get(pitches_url)
	# 	parsed_response = Nokogiri::XML(response)
	# 	#Pitch stupidly means at bat
	# 	pitches = parsed_response.css('pitch')
	# 	#The following should be its own function
	# 	pitches.each do |pitch|
	# 		pitch_attrs = self.parse_pitch(pitch)
	# 		new_pitch = Pitch.new
	# 		new_pitch.description = pitch_attrs[:description]
	# 		new_pitch.pid = pitch_attrs[:pid]
	# 		new_pitch.x_location = pitch_attrs[:x_location]
	# 		new_pitch.y_location = pitch_attrs[:y_location]
	# 		new_pitch.sz_top = pitch_attrs[:sz_top]
	# 		new_pitch.sz_bottom = pitch_attrs[:sz_bottom]
	# 		new_pitch.sv_id = pitch_attrs[:sv_id]
	# 		new_pitch.type_id = pitch_attrs[:type_id]
	# 		new_pitch.missing_data = pitch_attrs[:missing_data]
	# 		new_pitch.inning_half = pitch_attrs[:inning_half]
	# 		new_pitch.inning = pitch_attrs[:inning]
	# 		new_pitch.ball_count = pitch_attrs[:ball_count]
	# 		new_pitch.strike_count = pitch_attrs[:strike_count]
	# 		new_pitch.outs = pitch_attrs[:outs]
	# 		new_pitch.play = pitch_attrs[:play]
	# 		if (new_pitch.sz_top && (new_pitch.description == "Called Strike" || new_pitch.description == "Ball"))
	# 			new_pitch.correct_call = new_pitch.correct_call? 
	# 			if new_pitch.description == "Called Strike"
	# 				new_pitch.distance_missed_x = new_pitch.x_miss
	# 				new_pitch.distance_missed_y = new_pitch.y_miss
	# 				new_pitch.total_distance_missed = new_pitch.total_miss
	# 			end
	# 		end

	# 		if (new_pitch.sz_top == 0 || new_pitch.sz_top == 0)
	# 			new_pitch.missing_data = true
	# 		end

	# 		new_pitch.save!
	# 		pitch_array << new_pitch
	# 	end
	# 	pitch_array
	# end

	# def self.parse_pitch(pitch)
	# 	begin
	# 		count = self.get_count(pitch)
	# 		inning_half = pitch.parent.parent.name
	# 		inning = pitch.parent.parent.parent.attributes["num"].value
	# 		outs = self.get_outs(pitch)
	# 		play = self.get_play(pitch)
	# 		ball_count = count[:balls]
	# 		strike_count = count[:strikes]
	# 		description = pitch["des"]
	# 		pid = pitch["id"]
	# 		x_location = pitch["px"]
	# 		y_location = pitch["pz"]
	# 		sz_top = pitch["sz_top"]
	# 		sz_bottom = pitch["sz_bot"]
	# 		sv_id = pitch["sv_id"]
	# 		type_id = pitch["type"]
	# 		pitch_attrs = {inning_half: inning_half, inning: inning, ball_count: ball_count, strike_count: strike_count, outs: outs, play: play, description: description, pid: pid, x_location: x_location, y_location: y_location, sz_top: sz_top, sz_bottom: sz_bottom, sv_id: sv_id, type_id: type_id, missing_data: false}
	# 	rescue Exception => e
	# 		puts e.message
	# 		puts e.backtrace.inspect
	# 		pitch_attrs = {missing_data: true}
	# 	end
	# end

	# def self.get_count(pitch)
	# 	balls = 0
	# 	strikes = 0
	# 	pitch = pitch.previous
	# 	while pitch
	# 		if pitch["type"] == "S" && strikes < 2
	# 			strikes += 1
	# 		elsif pitch["type"] == "B" 
	# 			balls += 1
	# 		end

	# 		pitch = pitch.previous

	# 	end

	# 	count = {balls: balls, strikes: strikes}
	# end

	# def self.get_outs(pitch)
	# 	last_atbat = pitch.parent.previous
	# 	last_atbat ? last_atbat.attributes["o"].value.to_i : 0
	# end

	# def self.get_play(pitch)
	# 	last_atbat = pitch.parent
	# 	last_atbat["des"]
	# end



end