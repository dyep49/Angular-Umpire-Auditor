class AddIncorrectToGames < ActiveRecord::Migration
  def change
    add_column :games, :incorrect_calls, :integer
  end
end
