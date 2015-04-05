namespace :db do 
  desc "Adds defaults to game call count"
  task add_game_defaults: :environment do 
    Game.all.each do |game|
      if game.total_calls == nil
        game.total_calls = 0
      end

      if game.correct_calls == nil
        game.correct_calls = 0
      end

      if game.incorrect_calls == nil
        game.incorrect_calls = 0
      end

      if game.percent_correct == nil
        game.percent_correct = 0
      end

      game.save!
    end
  end
end
