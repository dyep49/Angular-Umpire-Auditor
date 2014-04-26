class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :game_date
      t.string :umpire
      t.string :home_team
      t.string :away_team
      t.float :total_distance_missed

      t.timestamps
    end
  end
end
