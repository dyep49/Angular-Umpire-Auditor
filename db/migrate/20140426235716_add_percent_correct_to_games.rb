class AddPercentCorrectToGames < ActiveRecord::Migration
  def change
    add_column :games, :percent_correct, :float
  end
end
