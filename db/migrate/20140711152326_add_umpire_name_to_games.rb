class AddUmpireNameToGames < ActiveRecord::Migration
  def change
    add_column :games, :umpire_name, :string
  end
end
