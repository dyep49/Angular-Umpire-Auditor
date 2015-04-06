require 'csv'

class Umpire < ActiveRecord::Base
	has_many :games

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