require 'csv'

class Umpire < ActiveRecord::Base
	has_many :games

  # def self.read_umpire_csv(options = {})
  #   file_path = options[:year] ? "#{Rails.root}/public/csvs/umpire_rank_#{options[:year]}.csv" : "#{Rails.root}/public/csvs/umpire_rank.csv"
  #   umpire_array = []
  #   CSV.foreach(file_path) do |csv_obj|
  #     percent_correct = (csv_obj[1].to_i/csv_obj[3].to_f) * 100

  #     umpire_hash = {}
  #     umpire_hash["name"] = csv_obj[0]
  #     umpire_hash["correctCalls"] = csv_obj[1].to_i
  #     umpire_hash["incorrectCalls"] = csv_obj[2].to_i
  #     umpire_hash["correctCallPercent"] = percent_correct
  #     umpire_hash["totalCalls"] = csv_obj[3].to_i
  #     id = Umpire.find_by(name: umpire_hash["name"]).id
  #     umpire_hash["id"] = id
      

  #     umpire_array << umpire_hash
  #   end
  #   umpire_array
  # end

  # def self.update_ranking
  #   file_path = "#{Rails.root}/public/csvs/tmp_umpire_rank.csv"
  #   Umpire.all.each do |umpire|
  #     CSV.open(file_path, "a") do |csv|
  #       call_hash = umpire.evaluate(umpire.games)
  #       unless call_hash[:total_calls] == 0
  #         csv << [umpire.name, call_hash[:correct_calls], call_hash[:incorrect_calls], call_hash[:total_calls]]
  #       end
  #     end
  #   end
  #   File.rename(file_path, "#{Rails.root}/public/csvs/umpire_rank.csv")
  # end

  def self.update_ranking(year = nil)
    umpire_ranking = []
    Umpire.all.each do |umpire|
      games = year ? umpire.games.select {|game| game.game_date.year == year } : umpire.games
      call_hash = umpire.evaluate(games)
      unless call_hash[:totalCalls] == 0
        call_hash[:name] = umpire.name
        call_hash[:id] = umpire.id
        umpire_ranking << call_hash
      end

      $redis.set("umpire_ranking#{year}", umpire_ranking.to_json)

      umpire_ranking
    end

  end

  def self.get_umpire_ranking(year = nil) 
    key = year ? "umpire_ranking#{year}" : "umpire_ranking"
    ranking = $redis.get(key)
    JSON.load(ranking)
  end

  # def self.update_year_ranking(year)
  #   file_path = "#{Rails.root}/public/csvs/tmp_umpire_rank_#{year}.csv"
  #   Umpire.all.each do |umpire|
  #     CSV.open(file_path, "a") do |csv|
  #       games = umpire.games.select {|game| game.game_date.year == year}
  #       call_hash = umpire.evaluate(games)
  #       unless call_hash[:total_calls] == 0
  #         csv << [umpire.name, call_hash[:correct_calls], call_hash[:incorrect_calls], call_hash[:total_calls]]
  #       end
  #     end
  #   end
  #   File.rename(file_path, "#{Rails.root}/public/csvs/umpire_rank_#{year}.csv")
  # end

  def evaluate(games)
    total_calls = 0
    correct_calls = 0
    incorrect_calls = 0
    games.each do |game|
      total_calls += game.total_calls
      correct_calls += game.correct_calls
      incorrect_calls += game.incorrect_calls
    end

    correct_call_percent = correct_calls.to_f / total_calls

    call_hash = {totalCalls: total_calls, correctCalls: correct_calls, incorrectCalls: incorrect_calls, correctCallPercent: correct_call_percent}
  end



end