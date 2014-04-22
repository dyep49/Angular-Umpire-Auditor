class CreateGamesTeams < ActiveRecord::Migration
  def change
    create_table :games_teams do |t|
      t.integer :game_id
      t.integer :team_id
    end
  end
end
