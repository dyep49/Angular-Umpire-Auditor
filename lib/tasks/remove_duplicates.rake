desc "Creates gid urls and seeds database"
task remove_duplicate_game: :environment do
  Game.all.each do |game|
    gid = game.gid
    games = Game.where(gid: gid)
    if games.length > 1
      games.first.pitches.delete_all
      games.first.destroy
    end
  end
end 



