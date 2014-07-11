namespace :db do 
  desc "Adds defaults to game call count"
  task add_umpire_name_to_game: :environment do 
    Game.all.each do |game|
      umpire = Umpire.find(game.umpire_id)
      game.umpire_name = umpire.name
      game.save!
    end
  end
end
