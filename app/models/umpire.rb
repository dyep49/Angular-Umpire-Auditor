require 'csv'

class Umpire < ActiveRecord::Base
	has_many :games

  def self.read_umpire_csv(options = {})
    file_path = options[:year] ? "#{Rails.root}/public/csvs/umpire_rank_#{options[:year]}.csv" : "#{Rails.root}/public/csvs/umpire_rank.csv"
    umpire_array = []
    CSV.foreach(file_path) do |csv_obj|
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

  def self.update_ranking
    file_path = "#{Rails.root}/public/csvs/tmp_umpire_rank.csv"
    Umpire.all.each do |umpire|
      CSV.open(file_path, "a") do |csv|
        call_hash = umpire.evaluate(umpire.games)
        unless call_hash[:total_calls] == 0
          csv << [umpire.name, call_hash[:correct_calls], call_hash[:incorrect_calls], call_hash[:total_calls]]
        end
      end
    end
    File.rename(file_path, "#{Rails.root}/public/csvs/umpire_rank.csv")
  end

  def self.update_year_ranking(year)
    file_path = "#{Rails.root}/public/csvs/tmp_umpire_rank_#{year}.csv}"
    Umpire.all.each do |umpire|
      CSV.open(file_path, "a") do |csv|
        games = umpire.games.select {|game| game.game_date.year == year}
        call_hash = umpire.evaluate(games)
        unless call_hash[:total_calls] == 0
          csv << [umpire.name, call_hash[:correct_calls], call_hash[:incorrect_calls], call_hash[:total_calls]]
        end
      end
    end
    File.rename(file_path, "#{Rails.root}/public/csvs/umpire_rank_#{year}.csv")
  end

  def evaluate(games)
    total_calls = 0
    correct_calls = 0
    incorrect_calls = 0
    games.each do |game|
      total_calls += game.total_calls
      correct_calls += game.correct_calls
      incorrect_calls += game.incorrect_calls
    end
    call_hash = {total_calls: total_calls, correct_calls: correct_calls, incorrect_calls: incorrect_calls}
  end



end