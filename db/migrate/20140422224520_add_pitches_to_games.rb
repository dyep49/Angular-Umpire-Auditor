class AddPitchesToGames < ActiveRecord::Migration
  def change
    add_column :games, :total_calls, :integer
    add_column :games, :correct_calls, :integer
  end
end
