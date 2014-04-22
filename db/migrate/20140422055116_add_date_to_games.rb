class AddDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_date, :datetime
  end
end
