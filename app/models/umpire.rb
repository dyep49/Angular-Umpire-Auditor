require 'csv'

class Umpire < ActiveRecord::Base
	has_many :games

  def self.read_umpire_csv
    umpire_array = []
    CSV.foreach("#{Rails.root}/public/csvs/umpire_rank.csv") do |csv_obj|
      percent_correct = (csv_obj[1].to_i/csv_obj[3].to_f) * 100

      umpire_hash = {}
      umpire_hash["name"] = csv_obj[0]
      umpire_hash["correctCalls"] = csv_obj[1]
      umpire_hash["incorrectCalls"] = csv_obj[2]
      umpire_hash["correctCallPercent"] = percent_correct
      umpire_hash["totalCalls"] = csv_obj[3]

      id = Umpire.find_by(name: umpire_hash["name"]).id
      umpire_hash["id"] = id
      

      umpire_array << umpire_hash
    end
    umpire_array
  end

end