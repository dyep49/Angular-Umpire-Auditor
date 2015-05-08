module BuildLinks

	ROOT_YEAR = Date.today.year

	URL_ROOT = "http://gd2.mlb.com/components/game/mlb/year_#{ROOT_YEAR}"

	def self.gid_info 
		start_date = Date.new(ROOT_YEAR, 01, 01)
		end_date = Date.new(ROOT_YEAR, 12, 31)

		(start_date..end_date).map do |date|
			self.parse_gids_by_date(date)
		end
	end

	def self.parse_gids_by_date(date)
		day_url = self.date_to_gids_url(date)
		gids = self.parse_gids(day_url)
	end

	private
	def self.parse_gids(day_url)
		response = HTTParty.get("#{day_url}")
		gids = response.scan(/gid[^\/]*/).uniq
		gids.map { |gid| "#{day_url}/#{gid}" }
	end

	private
	def self.date_to_gids_url(date)
		month = sprintf '%02d', date.month
		day = sprintf '%02d', date.day
		day_url = "#{URL_ROOT}/month_#{month}/day_#{day}"
	end

end

