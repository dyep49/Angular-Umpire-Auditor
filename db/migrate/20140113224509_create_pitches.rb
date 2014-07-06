class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.string :gid
      t.datetime :date_string
      t.string :description
      t.integer :pid
      t.float :x_location
      t.float :y_location
      t.float :sz_top
      t.float :sz_bottom
      t.string :sv_id
      t.string :type_id
      t.boolean :missing_data
      t.boolean :correct_call
      t.float :distance_missed_x, :default => 0
      t.float :distance_missed_y, :default => 0 
      t.float :total_distance_missed, :default => 0
      t.integer :pitcher_id
      t.integer :mlb_umpire_id
      t.integer :batter_id
      t.integer :game_id
    end
  end
end
