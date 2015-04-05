class AddDefaultValueToGameAttributes < ActiveRecord::Migration
  def change
    change_column :games, :total_calls, :integer, default: 0
    change_column :games, :correct_calls, :integer, default: 0
    change_column :games, :incorrect_calls, :integer, default: 0
    change_column :games, :percent_correct, :float, default: 0
  end
end
