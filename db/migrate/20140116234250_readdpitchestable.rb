class Readdpitchestable < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.string :gid
      t.string :date_string
      t.string :description
      t.integer :pid
      t.float :x_location
      t.float :y_location
      t.float :sz_top
      t.float :sz_bottom
      t.string :sv_id
      t.string :type_id
      t.boolean :correct_call
      t.float :distance_missed_x 
      t.float :distance_missed_y 
      t.float :total_distance_missed 
      t.boolean :missing_data
      t.integer :pitcher_id
      t.integer :mlb_umpire_id
      t.integer :batter_id
      t.integer :game_id
      # t.timestamps
    end
  end
end