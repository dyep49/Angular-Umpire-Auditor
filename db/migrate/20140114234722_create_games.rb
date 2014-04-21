class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.string :gid
      t.integer :mlb_umpire_id
      t.integer :umpire_id
      t.timestamps
    end
  end
end
