class AddTeamsToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_team_abbrev, :string
    add_column :games, :away_team_abbrev, :string
  end
end
