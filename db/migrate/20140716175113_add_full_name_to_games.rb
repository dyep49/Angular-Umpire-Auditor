class AddFullNameToGames < ActiveRecord::Migration
  def change
    add_column :games, :home_full_name, :string
    add_column :games, :away_full_name, :string
  end
end
