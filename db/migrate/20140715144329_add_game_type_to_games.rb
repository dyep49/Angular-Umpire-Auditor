class AddGameTypeToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_type, :string
  end
end
