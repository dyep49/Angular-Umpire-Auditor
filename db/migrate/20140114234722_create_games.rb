class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.string :gid
      t.integer :mlb_umpire_id
      t.integer :umpire_id
      t.datetime :game_date
      t.integer :total_calls
      t.integer :correct_calls
      t.integer :incorrect_calls
      t.string :home_team_abbrev
      t.string :away_team_abbrev
      t.float :percent_correct
    end
  end
end
