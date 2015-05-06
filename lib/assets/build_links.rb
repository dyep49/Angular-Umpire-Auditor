module BuildLinks

	ROOT_YEAR = Date.today.year

	URL_ROOT = "http://gd2.mlb.com/components/game/mlb/year_#{ROOT_YEAR}"

	def self.gid_info
		gids = []
		gid_url_array = []
		(1..12).each do |month|
			month = sprintf '%02d', month
			full_month = "month_#{month}"
			(1..31).each do |day|
				day = sprintf '%02d', day
				day_url = "#{URL_ROOT}/#{full_month}/day_#{day}"
				gids = self.parse_gids(day_url)
				gids.each do |gid|
					gid_url_array << "#{day_url}/#{gid}/"
				end
			end
		end
		gid_url_array
	end

	def self.parse_gids(day_url)
		response = HTTParty.get("#{day_url}")
		gids = response.scan(/gid[^\/]*/)
	end

	def self.parse_gids_by_date(date)
		gid_url_array = []
		day_url = self.date_to_gids_url(date)
		gids = self.parse_gids(day_url)
		gids.each do |gid|
			gid_url_array << "#{day_url}/#{gid}"
		end
		gid_url_array
	end

	def self.date_to_gids_url(date)
		month = sprintf '%02d', date.month
		day = sprintf '%02d', date.day
		day_url = "#{URL_ROOT}/month_#{month}/day_#{day}"
	end



end

