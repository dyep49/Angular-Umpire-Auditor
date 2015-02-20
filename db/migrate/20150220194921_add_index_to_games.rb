class AddIndexToGames < ActiveRecord::Migration
  def change
    add_index :games, :umpire_id
  end
end
